# Validate WinUtilX configuration and compile the generated PowerShell script.
# This script validates syntax but deliberately does not execute WinUtilX or apply system tweaks.

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
Push-Location $repoRoot

try {
    $configFiles = @(Get-ChildItem -Path ./config -Filter '*.json' -File)
    if ($configFiles.Count -eq 0) {
        throw 'No JSON configuration files were found in ./config.'
    }

    foreach ($file in $configFiles) {
        try {
            Get-Content -LiteralPath $file.FullName -Raw | ConvertFrom-Json -ErrorAction Stop | Out-Null
        }
        catch {
            throw "Invalid JSON in '$($file.FullName)': $($_.Exception.Message)"
        }
    }
    Write-Host "Validated $($configFiles.Count) JSON configuration files."

    & ./Compile.ps1
    if ($LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        throw "Compile.ps1 returned exit code $LASTEXITCODE."
    }

    $compiledPath = Join-Path $repoRoot 'winutil.ps1'
    if (-not (Test-Path -LiteralPath $compiledPath -PathType Leaf)) {
        throw 'Compile.ps1 did not produce winutil.ps1.'
    }

    $tokens = $null
    $parseErrors = $null
    [System.Management.Automation.Language.Parser]::ParseFile(
        $compiledPath,
        [ref]$tokens,
        [ref]$parseErrors
    ) | Out-Null

    if ($parseErrors.Count -gt 0) {
        $details = ($parseErrors | ForEach-Object {
            "Line $($_.Extent.StartLineNumber), column $($_.Extent.StartColumnNumber): $($_.Message)"
        }) -join [Environment]::NewLine
        throw "The compiled PowerShell script contains parser errors:`n$details"
    }

    Write-Host 'Compiled script passed PowerShell parser validation.'
}
finally {
    Pop-Location
}
