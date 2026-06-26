# Shared Helper Functions for Orchestra Validation and Update Scripts

$ErrorActionPreference = 'Stop'

function Get-ProjectRoot {
    # Returns the absolute path of the repository root
    return (Split-Path -Parent $PSScriptRoot)
}

function Get-Aliases {
    $root = Get-ProjectRoot
    $aliasPath = Join-Path $root 'aliases.json'
    if (Test-Path -LiteralPath $aliasPath) {
        return Get-Content -LiteralPath $aliasPath -Raw | ConvertFrom-Json
    }
    return @{}
}

function Resolve-Slug {
    param([string]$Slug)
    $aliases = Get-Aliases
    if ($aliases.PSObject.Properties[$Slug]) {
        return $aliases.$Slug
    }
    return $Slug
}

function Test-FileNotEmpty {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return $false
    }
    try {
        $item = Get-Item -LiteralPath $Path -ErrorAction Stop
        if ($item.Length -lt 10) {
            return $false
        }
    }
    catch {
        return $false
    }
    return $true
}

function Write-ColorHost {
    param(
        [ValidateSet('INFO', 'SUCCESS', 'WARNING', 'ERROR')]
        [string]$Type,
        [string]$Message
    )

    $color = switch ($Type) {
        'SUCCESS' { 'Green' }
        'WARNING' { 'Yellow' }
        'ERROR'   { 'Red' }
        default   { 'Cyan' }
    }

    Write-Host "[$Type] $Message" -ForegroundColor $color
}

function Get-JsonManifest {
    param([string]$Path = "")
    $root = Get-ProjectRoot
    if ([string]::IsNullOrEmpty($Path)) {
        $Path = Join-Path $root 'plugin.json'
    }
    if (-not (Test-Path -LiteralPath $Path)) {
        throw "Manifest file not found at: $Path"
    }
    return Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json
}

function Parse-Frontmatter {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        throw "File not found: $Path"
    }
    $content = Get-Content -LiteralPath $Path -Raw
    if ($content -match '(?sm)^---\s*(.*?)\s*---') {
        $frontmatterText = $matches[1]
        $fields = [ordered]@{}
        
        # Parse simple key-value YAML fields
        $lines = $frontmatterText -split "\r?\n"
        foreach ($line in $lines) {
            if ($line -match "^([^:]+):\s*(.*)$") {
                $key = $matches[1].Trim()
                $val = $matches[2].Trim()
                $fields[$key] = $val
            }
        }
        return $fields
    }
    throw "Frontmatter not found in file: $Path"
}
