# Safe Plugin Update Workflow (Refactored)
# Dot-sources shared helper functions.

param (
    [string]$RepoPath = ".",
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

# Import shared helpers from the script directory
$scriptDir = $PSScriptRoot
$helpersPath = Join-Path $scriptDir 'helpers.ps1'
if (Test-Path $helpersPath) {
    . $helpersPath
}

Write-ColorHost 'INFO' "Conductor: Safe Plugin Update Workflow"
Write-ColorHost 'INFO' "=============================================="

# Ensure RepoPath exists
if (-not (Test-Path -Path $RepoPath)) {
    Write-ColorHost 'ERROR' "The specified RepoPath does not exist: $RepoPath"
    exit 1
}

# Change directory to RepoPath
Push-Location -Path $RepoPath

try {
    # 1. Detect if inside a git repository
    $isGitRepo = $null
    try {
        $isGitRepo = git rev-parse --is-inside-work-tree 2>&1
    } catch {
        Write-ColorHost 'ERROR' "Not a git repository. The safe update script requires a git-cloned installation."
        exit 1
    }

    if ($isGitRepo -notmatch "true") {
        Write-ColorHost 'ERROR' "Not a git repository. The safe update script requires a git-cloned installation."
        exit 1
    }

    # 2. Detect the actual git repo root
    $repoRoot = git rev-parse --show-toplevel
    Write-ColorHost 'INFO' "Repository root detected: $repoRoot"

    # 3. Stop if the working tree has uncommitted changes
    $status = git status --porcelain
    if ($status) {
        Write-ColorHost 'ERROR' "Working tree has uncommitted changes. Please commit or stash them before updating."
        Write-ColorHost 'WARNING' "Changes:"
        Write-Host $status
        exit 1
    }

    # 4. Detect current branch
    $currentBranch = git branch --show-current
    if ([string]::IsNullOrWhiteSpace($currentBranch)) {
        Write-ColorHost 'ERROR' "Could not detect the current branch. Are you in a detached HEAD state?"
        exit 1
    }
    Write-ColorHost 'INFO' "Current branch: $currentBranch"

    if ($DryRun) {
        Write-ColorHost 'WARNING' "[DRY RUN] Would run: git fetch"
        Write-ColorHost 'WARNING' "[DRY RUN] Would run: git pull origin $currentBranch"
        Write-ColorHost 'WARNING' "[DRY RUN] Would run: .\scripts\validate-manifest.ps1"
        Write-ColorHost 'WARNING' "[DRY RUN] Would run: .\scripts\validate-structure.ps1"
        Write-ColorHost 'SUCCESS' "Dry run complete. No changes made."
        exit 0
    }

    # 5. Run git fetch
    Write-ColorHost 'INFO' "Fetching latest changes from remote..."
    $prevErrorAction = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    git fetch
    if ($LASTEXITCODE -ne 0) {
        Write-ColorHost 'ERROR' "git fetch failed. Please check your network connection."
        exit 1
    }
    $ErrorActionPreference = $prevErrorAction

    # 6. Pull the latest changes for the current branch
    Write-ColorHost 'INFO' "Pulling latest changes for branch '$currentBranch'..."
    $prevErrorAction = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    git pull origin $currentBranch
    if ($LASTEXITCODE -ne 0) {
        Write-ColorHost 'ERROR' "git pull failed. Please check your network or resolve conflicts manually."
        exit 1
    }
    $ErrorActionPreference = $prevErrorAction

    # 7. Run validations
    Write-ColorHost 'INFO' "Running validation scripts..."
    
    $manifestScript = Join-Path $repoRoot "scripts\validate-manifest.ps1"
    $structureScript = Join-Path $repoRoot "scripts\validate-structure.ps1"

    $psExe = (Get-Process -Id $PID).Path
    if (Test-Path $manifestScript) {
        Write-ColorHost 'INFO' "Validating manifest..."
        & $psExe -ExecutionPolicy Bypass -File $manifestScript
        if ($LASTEXITCODE -ne 0) {
            Write-ColorHost 'ERROR' "Manifest validation failed! Rollback recommended."
            exit 1
        }
    } else {
        Write-ColorHost 'WARNING' "validate-manifest.ps1 not found."
    }

    if (Test-Path $structureScript) {
        Write-ColorHost 'INFO' "Validating structure..."
        & $psExe -ExecutionPolicy Bypass -File $structureScript
        if ($LASTEXITCODE -ne 0) {
            Write-ColorHost 'ERROR' "Structure validation failed! Rollback recommended."
            exit 1
        }
    } else {
        Write-ColorHost 'WARNING' "validate-structure.ps1 not found."
    }

    Write-ColorHost 'SUCCESS' "Update and validation completed successfully!"
    Write-ColorHost 'INFO' "Next Steps:"
    Write-Host "  - For Antigravity: Reload your plugins or restart the terminal session."
    Write-Host "  - For Codex: Restart the agent workspace to load the updated skills."

} finally {
    Pop-Location
}
