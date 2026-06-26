$Root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

$scripts = @(
    @{ Name = "validate-structure.ps1"; Path = "scripts/validate-structure.ps1" },
    @{ Name = "validate-manifest.ps1"; Path = "scripts/validate-manifest.ps1" },
    @{ Name = "check-stale-references.ps1"; Path = "scripts/check-stale-references.ps1" },
    @{ Name = "validate-codex-export.ps1"; Path = "adapters/codex/validate-codex-export.ps1" }
)

$failed = $false

foreach ($s in $scripts) {
    Write-Host "========================================"
    Write-Host "Running $($s.Name)..."
    Write-Host "========================================"
    
    $fullPath = Join-Path $Root $s.Path
    $psExe = (Get-Process -Id $PID).Path
    & $psExe -NoProfile -ExecutionPolicy Bypass -File $fullPath
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: $($s.Name) failed with exit code $LASTEXITCODE!" -ForegroundColor Red
        $failed = $true
    } else {
        Write-Host "SUCCESS: $($s.Name) passed." -ForegroundColor Green
    }
}

Write-Host "========================================"
if ($failed) {
    Write-Host "Validation suite FAILED." -ForegroundColor Red
    exit 1
} else {
    Write-Host "Validation suite PASSED!" -ForegroundColor Green
    exit 0
}
