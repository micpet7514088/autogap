# install.ps1 -- install the autogap Claude Code skill
#
# Usage:
#   .\install.ps1           install (or skip if already installed)
#   .\install.ps1 -Update   reinstall, overwriting an existing installation
#
# Remote one-liner (PowerShell 7+):
#   Invoke-RestMethod https://raw.githubusercontent.com/micpet7514088/autogap/main/install.ps1 | Invoke-Expression

#Requires -Version 7
param(
    [switch]$Update
)

$ErrorActionPreference = "Stop"

$Repo = "https://github.com/micpet7514088/autogap"
$Raw  = "https://raw.githubusercontent.com/micpet7514088/autogap/main"

$SkillsDir  = Join-Path $env:USERPROFILE ".claude\skills"
$SkillDir   = Join-Path $SkillsDir "autogap"
$SkillDst   = Join-Path $SkillDir "SKILL.md"

# Detect whether we are running from the cloned repo or via Invoke-Expression.
# $MyInvocation.MyCommand.Path is empty when the script is piped / iex'd.
$ScriptDir  = ""
$ScriptPath = $MyInvocation.MyCommand.Path
if ($ScriptPath) {
    $ScriptDir = Split-Path -Parent $ScriptPath
}

$UseSymlink = $false
$SkillSrc   = ""
if ($ScriptDir) {
    $candidate = Join-Path $ScriptDir "skills\autogap\SKILL.md"
    if (Test-Path $candidate) {
        $SkillSrc   = $candidate
        $UseSymlink = $true
    }
}

# Check if already installed
if (Test-Path $SkillDst) {
    if (-not $Update) {
        Write-Host "autogap is already installed at $SkillDst"
        Write-Host "Run with -Update to reinstall."
        exit 0
    }
    Write-Host "Updating existing installation..."
    Remove-Item $SkillDst -Force
}

New-Item -ItemType Directory -Path $SkillDir -Force | Out-Null

if ($UseSymlink) {
    # Try creating a symlink (requires Developer Mode or admin rights on Windows).
    $linked = $false
    try {
        New-Item -ItemType SymbolicLink -Path $SkillDst -Target $SkillSrc -ErrorAction Stop | Out-Null
        $linked = $true
    } catch {
        # Symlink creation failed; fall through to copy.
    }

    if ($linked) {
        Write-Host "autogap installed (symlinked -- updates propagate automatically when you pull)."
        Write-Host "Repo: $ScriptDir"
    } else {
        Copy-Item $SkillSrc $SkillDst
        Write-Host "autogap installed (copied -- symlink unavailable; run .\install.ps1 -Update after pulling new versions)."
        Write-Host "Tip: enable Windows Developer Mode to allow symlinks without admin rights."
    }
} else {
    # Remote install: download SKILL.md directly.
    $url = "$Raw/skills/autogap/SKILL.md"
    try {
        Invoke-WebRequest -Uri $url -OutFile $SkillDst -UseBasicParsing
    } catch {
        Write-Error "Download failed from $url. Clone the repo and run .\install.ps1 instead:"
        Write-Error "  git clone $Repo ~\autogap; ~\autogap\install.ps1"
        exit 1
    }
    Write-Host "autogap installed (downloaded -- run .\install.ps1 -Update after new releases)."
}

Write-Host ""
Write-Host "Restart Claude Code. Then from any project directory:"
Write-Host "  claude"
Write-Host "  > /autogap"
