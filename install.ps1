# WinUtilX launcher
# Downloads the latest compiled WinUtilX release and runs it.
# Source: https://github.com/MohamedBabaamer/WinUtilX

$ErrorActionPreference = 'Stop'

$repo = 'MohamedBabaamer/WinUtilX'
$api = "https://api.github.com/repos/$repo/releases/latest"

Write-Host 'Downloading latest WinUtilX release...' -ForegroundColor Cyan

$release = Invoke-RestMethod -Uri $api -Headers @{ 'User-Agent' = 'WinUtilX' }

$asset = $release.assets | Where-Object { $_.name -eq 'winutilx.ps1' } | Select-Object -First 1

if (-not $asset) {
    throw 'No winutilx.ps1 asset was found in the latest WinUtilX release.'
}

$temp = Join-Path $env:TEMP 'WinUtilX'
New-Item -ItemType Directory -Path $temp -Force | Out-Null

$scriptPath = Join-Path $temp 'winutilx.ps1'

Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $scriptPath -UseBasicParsing

Write-Host 'Starting WinUtilX...' -ForegroundColor Green

$hostExe = if ($PSVersionTable.PSEdition -eq 'Core') { 'pwsh.exe' } else { 'powershell.exe' }
& $hostExe -ExecutionPolicy Bypass -NoProfile -File $scriptPath
