# Programmatic Runtime Guardrail Check for Orchestra AI workflows
# Checks files/changes for potential secrets, copyleft licensing, PII leaks, or cross-repo modifications.

param(
    [string]$TargetDir = (Split-Path -Parent $PSScriptRoot),
    [switch]$StagedOnly
)

$ErrorActionPreference = 'Stop'

# Source common helpers
$helpers = Join-Path $PSScriptRoot 'helpers.ps1'
if (Test-Path $helpers) {
    . $helpers
}

Write-ColorHost 'INFO' 'Orchestra Programmatic Guardrail: Commencing scanning...'

$violations = @()

# 1. Gather files/changes to scan
$filesToScan = @()
if ($StagedOnly) {
    # Check if git is available
    try {
        $staged = git diff --name-only --cached 2>$null
        if ($LASTEXITCODE -eq 0 -and $staged) {
            foreach ($f in $staged) {
                $fullPath = Join-Path $TargetDir $f
                if (Test-Path -LiteralPath $fullPath -PathType Leaf) {
                    $filesToScan += [PSCustomObject]@{ Path = $fullPath; Relative = $f }
                }
            }
        }
    }
    catch {
        Write-ColorHost 'WARNING' 'Git diff failed or not a git repo. Scanning target directory recursively instead.'
    }
}

if ($filesToScan.Count -eq 0) {
    # Scan target directory recursively (skipping standard exclusions)
    $files = Get-ChildItem -Path $TargetDir -Recurse -File | Where-Object {
        $_.FullName -notmatch '[\\/]\.git[\\/]' -and
        $_.FullName -notmatch '[\\/]brain[\\/]' -and
        $_.Extension -notin @('.ico', '.png', '.jpg', '.zip', '.tar', '.gz')
    }
    foreach ($f in $files) {
        $relative = $f.FullName.Substring($TargetDir.Length + 1)
        $filesToScan += [PSCustomObject]@{ Path = $f.FullName; Relative = $relative }
    }
}

# 2. Scans
foreach ($item in $filesToScan) {
    $content = Get-Content -LiteralPath $item.Path -Raw
    $lines = Get-Content -LiteralPath $item.Path

    # A. Secrets Check
    $secretPatterns = @{
        'AWS Access Key ID'  = '\bAKIA[0-9A-Z]{16}\b'
        'Slack Webhook'      = 'https://hooks\.slack\.com/services/T[A-Z0-9]+/B[A-Z0-9]+/[A-Za-z0-9]+'
        'Generic API Key'    = '(?i)api[_-]?key\s*[:=]\s*["''][A-Za-z0-9_\-+=]{16,}["'']'
        'Private Key Header' = '-----BEGIN[ A-Z]+PRIVATE KEY-----'
    }

    foreach ($key in $secretPatterns.Keys) {
        $pattern = $secretPatterns[$key]
        for ($i = 0; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -match $pattern) {
                $violations += "SECRET EXPOSURE ($key) in $($item.Relative):L$($i + 1) -> $($lines[$i].Trim())"
            }
        }
    }

    # B. License Compliance Check
    # Scan for copyleft licenses (GPL/AGPL/LGPL) in commercial/private context
    # Only if package.json or dependencies are modified
    if ($item.Relative -match 'package\.json|dependencies|plugin\.json') {
        $copyleftPatterns = @('(?i)"gpl', '(?i)"agpl', '(?i)"lgpl', '(?i)"copyleft')
        for ($i = 0; $i -lt $lines.Count; $i++) {
            foreach ($p in $copyleftPatterns) {
                if ($lines[$i] -match $p) {
                    $violations += "COPYLEFT LICENSE DETECTED ($($lines[$i].Trim())) in $($item.Relative):L$($i + 1). Please confirm compatibility."
                }
            }
        }
    }

    # C. PII Detection without Privacy Policy check
    # Check if file adds PII collection fields
    $piiPatterns = @('(?i)\bSSN\b', '(?i)\bsocial\s+security\b', '(?i)\bcredit\s*card\b', '(?i)\bcard[_-]?number\b')
    $hasPii = $false
    for ($i = 0; $i -lt $lines.Count; $i++) {
        foreach ($p in $piiPatterns) {
            if ($lines[$i] -match $p) {
                $hasPii = $true
                $violations += "PII SENSITIVE FIELD DETECTED ($($lines[$i].Trim())) in $($item.Relative):L$($i + 1)."
            }
        }
    }

    if ($hasPii) {
        # Check if Privacy Policy file exists in docs or root
        $privacyDocs = @('PrivacyPolicy.md', 'PRIVACY_POLICY.md', 'PRIVACY.md', 'docs/PRIVACY.md', 'docs/governance/PRIVACY.md')
        $hasPrivacyDoc = $false
        foreach ($doc in $privacyDocs) {
            if (Test-Path (Join-Path $TargetDir $doc)) {
                $hasPrivacyDoc = $true
                break
            }
        }
        if (-not $hasPrivacyDoc) {
            $violations += "PRIVACY GAPS: PII fields collected in $($item.Relative) but no PRIVACY_POLICY.md file was found."
        }
    }
}

# 3. Report Results
if ($violations.Count -gt 0) {
    Write-ColorHost 'ERROR' "Guardrail scan failed with $($violations.Count) safety warnings:"
    foreach ($v in $violations) {
        Write-ColorHost 'WARNING' " - $v"
    }
    exit 1
}

Write-ColorHost 'SUCCESS' 'Guardrail scan passed successfully! No programmatic safety issues found.'
exit 0
