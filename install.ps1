#Requires -Version 5.1
# Installs the Artificial Unintelligence Skills (skill + slash commands) into your
# Claude config folder. Runs on Windows PowerShell 5.1 and PowerShell Core (mac/Linux).
#
# Usage:
#   .\install.ps1               Install/update for your user (~/.claude)
#   .\install.ps1 -Project      Install into this project (.\.claude)
#   .\install.ps1 -Dir PATH     Install into a .claude folder you choose
#   .\install.ps1 -Desktop      Build plain-speak.zip to upload to Claude Desktop
#   .\install.ps1 -Status       Show installed vs. available version
#   .\install.ps1 -Uninstall    Remove the skill and commands
#   .\install.ps1 -Force        Reinstall without prompting
#   .\install.ps1 -ShowVersion  Print the version of this source
#   .\install.ps1 -Help

[CmdletBinding()]
param(
  [switch]$Project,
  [string]$Dir,
  [switch]$Desktop,
  [switch]$Status,
  [switch]$Uninstall,
  [switch]$Force,
  [switch]$ShowVersion,
  [switch]$Help
)

$ErrorActionPreference = 'Stop'

# Where this script lives, so it works no matter where you run it from.
$SrcDir = Split-Path -Parent $PSCommandPath

# Each skill is a top-level folder containing a SKILL.md.
$Skills = @('plain-speak')

# Single source of truth for the version. A marker file with this number is
# written into the install dir so re-running can tell install from update.
$VersionFile = Join-Path $SrcDir 'VERSION'
$Version = if (Test-Path $VersionFile) { (Get-Content $VersionFile -Raw).Trim() } else { '0.0.0' }
$Marker = '.aus-version'
$RawVersionUrl = 'https://raw.githubusercontent.com/walangstudio/aus/main/VERSION'

if ($Help) {
  Get-Content $PSCommandPath | Select-Object -Skip 1 -First 17 | ForEach-Object { $_ -replace '^# ?', '' }
  exit 0
}
if ($ShowVersion) { Write-Host "aus $Version"; exit 0 }

# Returns: 0 equal, 1 if A > B, 2 if A < B. Pads missing parts with 0.
function Compare-Ver([string]$A, [string]$B) {
  if ($A -eq $B) { return 0 }
  $x = $A.Split('.'); $y = $B.Split('.')
  for ($i = 0; $i -lt 3; $i++) {
    $a = if ($i -lt $x.Count) { [int]$x[$i] } else { 0 }
    $b = if ($i -lt $y.Count) { [int]$y[$i] } else { 0 }
    if ($a -gt $b) { return 1 }
    if ($a -lt $b) { return 2 }
  }
  return 0
}

$Home_ = if ($env:USERPROFILE) { $env:USERPROFILE } else { $env:HOME }

# Claude Desktop (and claude.ai) has no drop-in skills folder. You add a skill by
# uploading a zip of its folder in Settings > Customize > Skills > Create skill.
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
  Write-Host "Slash commands (/aus, /tldr, /eli, /huh) are Claude Code only."
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
$MarkerPath = Join-Path $Base $Marker

if ($Status) {
  Write-Host "Source version:    $Version"
  if (Test-Path $MarkerPath) {
    Write-Host "Installed version: $((Get-Content $MarkerPath -Raw).Trim()) ($Base)"
  } else {
    Write-Host "Installed version: not installed ($Base)"
  }
  # Best-effort latest-version check; stays quiet when offline.
  try {
    $latest = (Invoke-RestMethod -Uri $RawVersionUrl -TimeoutSec 5).ToString().Trim()
    if ((Compare-Ver $latest $Version) -eq 1) {
      Write-Host "Latest on GitHub:  $latest - update available. Pull and re-run install.ps1"
    } else {
      Write-Host "Latest on GitHub:  $latest - you are up to date."
    }
  } catch {}
  exit 0
}

if ($Uninstall) {
  Write-Host "Removing from: $Base"
  foreach ($skill in $Skills) {
    $dest = Join-Path $SkillsDir $skill
    if (Test-Path $dest) { Remove-Item $dest -Recurse -Force; Write-Host "  - skill $skill" }
  }
  $cmdSrc = Join-Path $SrcDir 'commands'
  if (Test-Path $cmdSrc) {
    foreach ($cmd in Get-ChildItem (Join-Path $cmdSrc '*.md')) {
      $target = Join-Path $CommandsDir $cmd.Name
      if (Test-Path $target) { Remove-Item $target -Force; Write-Host "  - /$($cmd.BaseName)" }
    }
  }
  if (Test-Path $MarkerPath) { Remove-Item $MarkerPath -Force }
  Write-Host "Done. Removed the skill and commands (left other files in $Base alone)."
  exit 0
}

New-Item -ItemType Directory -Force -Path $SkillsDir, $CommandsDir | Out-Null

# Tell install from update by comparing the marker to the source version.
if (Test-Path $MarkerPath) {
  $installed = (Get-Content $MarkerPath -Raw).Trim()
  switch (Compare-Ver $installed $Version) {
    0 {
      Write-Host "v$Version already installed in $Base."
      if (-not $Force) {
        $ans = Read-Host "Reinstall? [y/N]"
        if ($ans -notmatch '^[Yy]$') { Write-Host "Nothing to do."; exit 0 }
      }
    }
    1 {
      Write-Host "Installed v$installed is newer than this source v$Version."
      if (-not $Force) { Write-Host "Use -Force to downgrade."; exit 0 }
      Write-Host "Forcing downgrade to v$Version..."
    }
    2 { Write-Host "Updating $Base from v$installed to v$Version..." }
  }
} else {
  Write-Host "Installing v$Version into: $Base"
}

Write-Host "Skills -> $SkillsDir"
foreach ($skill in $Skills) {
  $src = Join-Path $SrcDir $skill
  if (-not (Test-Path (Join-Path $src 'SKILL.md'))) {
    Write-Warning "  skipping '$skill' (no SKILL.md found)"; continue
  }
  $dest = Join-Path $SkillsDir $skill
  if (Test-Path $dest) {
    Write-Host "  ~ replacing '$skill'"; Remove-Item $dest -Recurse -Force
  } else {
    Write-Host "  + installing '$skill'"
  }
  Copy-Item $src $dest -Recurse
}

Write-Host "Commands -> $CommandsDir"
$cmdSrc = Join-Path $SrcDir 'commands'
if (Test-Path $cmdSrc) {
  foreach ($cmd in Get-ChildItem (Join-Path $cmdSrc '*.md')) {
    $target = Join-Path $CommandsDir $cmd.Name
    if (Test-Path $target) { Write-Host "  ~ replacing /$($cmd.BaseName)" } else { Write-Host "  + installing /$($cmd.BaseName)" }
    Copy-Item $cmd.FullName $target -Force
  }
}

Set-Content -Path $MarkerPath -Value $Version -NoNewline
Write-Host ""
Write-Host "Done (v$Version). Start a new Claude session, then try /aus, /tldr, /eli, or /huh."
