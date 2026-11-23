# Adds the beep hooks to your Claude Code user settings (~/.claude/settings.json).
# Keeps everything already there, makes a backup first, and skips any event that already beeps.
$ErrorActionPreference = 'Stop'
$dir  = Join-Path $env:USERPROFILE '.claude'
$path = Join-Path $dir 'settings.json'
$src  = Join-Path $PSScriptRoot 'hooks.json'

if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
if (Test-Path $path) {
    Copy-Item $path "$path.bak-$(Get-Date -Format yyyyMMdd-HHmmss)"
    $raw = Get-Content $path -Raw
    if ([string]::IsNullOrWhiteSpace($raw)) { $settings = New-Object psobject } else { $settings = $raw | ConvertFrom-Json }
} else {
    $settings = New-Object psobject
}
$beep = (Get-Content $src -Raw | ConvertFrom-Json).hooks

if (-not $settings.PSObject.Properties['hooks']) {
    $settings | Add-Member -NotePropertyName hooks -NotePropertyValue (New-Object psobject)
}
foreach ($evt in 'Stop', 'Notification') {
    $existing = @()
    if ($settings.hooks.PSObject.Properties[$evt]) { $existing = @($settings.hooks.$evt) }
    if (($existing | ConvertTo-Json -Depth 20 -Compress) -match 'beep\(') {
        Write-Host "$evt already has a beep hook - skipped."
        continue
    }
    $merged = @($existing) + @($beep.$evt)
    if ($settings.hooks.PSObject.Properties[$evt]) { $settings.hooks.$evt = $merged }
    else { $settings.hooks | Add-Member -NotePropertyName $evt -NotePropertyValue $merged }
    Write-Host "$evt beep added."
}
$json = $settings | ConvertTo-Json -Depth 20
[System.IO.File]::WriteAllText($path, $json, (New-Object System.Text.UTF8Encoding($false)))
Write-Host "Saved $path. Restart Claude Code to hear it."
