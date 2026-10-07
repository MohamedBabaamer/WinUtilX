# WinUtilX launcher
# Downloads the latest release; if no release exists yet, builds from source.
# Source: https://github.com/MohamedBabaamer/WinUtilX

$ErrorActionPreference = 'Stop'

$repo = 'MohamedBabaamer/WinUtilX'
$temp = Join-Path $env:TEMP 'WinUtilX'
New-Item -ItemType Directory -Path $temp -Force | Out-Null

Write-Host 'Starting WinUtilX...' -ForegroundColor Cyan

try {
    $release = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases/latest" -Headers @{ 'User-Agent' = 'WinUtilX' }
    $asset = $release.assets | Where-Object { $_.name -eq 'winutilx.ps1' } | Select-Object -First 1

    if ($asset) {
        $scriptPath = Join-Path $temp 'winutilx.ps1'
        Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $scriptPath -UseBasicParsing

        $hostExe = if ($PSVersionTable.PSEdition -eq 'Core') { 'pwsh.exe' } else { 'powershell.exe' }
        & $hostExe -ExecutionPolicy Bypass -NoProfile -File $scriptPath
        exit $LASTEXITCODE
    }
}
catch {
    Write-Host 'No published WinUtilX release is available yet. Building from source...' -ForegroundColor Yellow
}

$zip = Join-Path $temp 'WinUtilX-source.zip'
$source = Join-Path $temp 'WinUtilX-source'

if (Test-Path $source) {
    Remove-Item $source -Recurse -Force
}

Invoke-WebRequest -Uri "https://github.com/$repo/archive/refs/heads/main.zip" -OutFile $zip -UseBasicParsing
Expand-Archive -Path $zip -DestinationPath $temp -Force

$extracted = Join-Path $temp 'WinUtilX-main'
if (-not (Test-Path $extracted)) {
    throw 'Could not find the extracted WinUtilX source directory.'
}

Move-Item $extracted $source
Remove-Item $zip -Force

Push-Location $source
try {
    & powershell.exe -ExecutionPolicy Bypass -NoProfile -File .Compile.ps1 -Run
}
finally {
    Pop-Location
}
