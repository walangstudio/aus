#Requires -Version 5.1
# Installs the Artificial Unintelligence Skills (skill + slash commands) into your
# Claude config folder. Runs on Windows PowerShell 5.1 and PowerShell Core (mac/Linux).
#
# Usage:
#   .\install.ps1               Install for your user (~/.claude)
#   .\install.ps1 -Project      Install into this project (.\.claude)
#   .\install.ps1 -Dir PATH     Install into a .claude folder you choose
#   .\install.ps1 -Desktop      Build plain-speak.zip to upload to Claude Desktop
#   .\install.ps1 -Help

[CmdletBinding()]
param(
  [switch]$Project,
  [string]$Dir,
  [switch]$Desktop,
  [switch]$Help
)

$ErrorActionPreference = 'Stop'

if ($Help) {
  Get-Content $PSCommandPath | Select-Object -Skip 1 -First 9 | ForEach-Object { $_ -replace '^# ?', '' }
  exit 0
}

# Where this script lives, so it works no matter where you run it from.
$SrcDir = Split-Path -Parent $PSCommandPath

# Each skill is a top-level folder containing a SKILL.md.
$Skills = @('plain-speak')

$Home_ = if ($env:USERPROFILE) { $env:USERPROFILE } else { $env:HOME }

# Claude Desktop (and claude.ai) has no drop-in skills folder. You add a skill by
# uploading a zip of its folder in Settings > Customize > Skills > Create skill.
# So for -Desktop we just build that zip and tell you what to do with it.
if ($Desktop) {
  foreach ($skill in $Skills) {
    if (-not (Test-Path (Join-Path $SrcDir "$skill\SKILL.md"))) {
      Write-Warning "skipping '$skill' (no SKILL.md)"; continue
    }
    $out = Join-Path $SrcDir "$skill.zip"
    if (Test-Path $out) { Remove-Item $out -Force }
    Compress-Archive -Path (Join-Path $SrcDir $skill) -DestinationPath $out
    Write-Host "Built $out"
  }
  Write-Host ""
  Write-Host "To use these in the Claude Desktop app or claude.ai:"
  Write-Host "  1. Open Settings > Customize > Skills."
  Write-Host "  2. Click '+ Create skill' and upload the .zip above."
  Write-Host "  3. Toggle the skill on."
  Write-Host "Note: the /aus, /tldr, /eli, /huh slash commands are Claude Code only and"
  Write-Host "do not appear in the desktop or web app."
  exit 0
}

if ($Dir) {
  $Base = $Dir
} elseif ($Project) {
  $Base = Join-Path (Get-Location) '.claude'
} else {
  $Base = Join-Path $Home_ '.claude'
}

$SkillsDir = Join-Path $Base 'skills'
$CommandsDir = Join-Path $Base 'commands'
New-Item -ItemType Directory -Force -Path $SkillsDir, $CommandsDir | Out-Null

Write-Host "Installing into: $Base"

Write-Host "Skills -> $SkillsDir"
foreach ($skill in $Skills) {
  $src = Join-Path $SrcDir $skill
  if (-not (Test-Path (Join-Path $src 'SKILL.md'))) {
    Write-Warning "  skipping '$skill' (no SKILL.md found)"; continue
  }
  $dest = Join-Path $SkillsDir $skill
  if (Test-Path $dest) {
    Write-Host "  ~ replacing '$skill'"
    Remove-Item $dest -Recurse -Force
  } else {
    Write-Host "  + installing '$skill'"
  }
  Copy-Item $src $dest -Recurse
}

Write-Host "Commands -> $CommandsDir"
$cmdSrc = Join-Path $SrcDir 'commands'
if (Test-Path $cmdSrc) {
  foreach ($cmd in Get-ChildItem (Join-Path $cmdSrc '*.md')) {
    $name = $cmd.Name
    $slash = $name -replace '\.md$', ''
    if (Test-Path (Join-Path $CommandsDir $name)) {
      Write-Host "  ~ replacing /$slash"
    } else {
      Write-Host "  + installing /$slash"
    }
    Copy-Item $cmd.FullName (Join-Path $CommandsDir $name) -Force
  }
}

Write-Host ""
Write-Host "Done. Start a new Claude session, then try /aus, /tldr, /eli, or /huh."
