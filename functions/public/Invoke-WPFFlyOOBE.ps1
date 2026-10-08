function Invoke-WPFFlyOOBE {
    Start-WinUtilJob -Name "FlyOOBE" -Description "Downloading Flyoobe" -Parameters @{
        DownloadPath = Join-Path $sync.winutildir "FlyOOBE-download"
    } -ScriptBlock {
        param($DownloadPath)

        $apiUri = "https://api.github.com/repos/builtbybel/FlyOOBE/releases/latest"
        Write-WinUtilLog -Component "FlyOOBE" -Message "Checking the official Flyoobe release."
        $release = Invoke-RestMethod -Uri $apiUri -Headers @{
            Accept = "application/vnd.github+json"
            "User-Agent" = "WinUtilX"
        } -ErrorAction Stop

        if (-not $release.assets) {
            throw "The latest official Flyoobe release has no downloadable assets."
        }

        # Prefer the actual application package, not optional Actions/data/source archives.
        $assets = @($release.assets)
        $asset = $assets |
            Where-Object { $_.name -match '\.exe$' } |
            Sort-Object @{ Expression = { if ($_.name -match '(?i)flyoobe') { 0 } else { 1 } } } |
            Select-Object -First 1

        if (-not $asset) {
            $asset = $assets |
                Where-Object {
                    $_.name -match '(?i)flyoobe.*\.zip$' -and
                    $_.name -notmatch '(?i)(actions|source|symbols|debug|database|rules|recipe)'
                } |
                Select-Object -First 1
        }

        if (-not $asset) {
            $asset = $assets |
                Where-Object { $_.name -match '\.(exe|zip)$' -and $_.name -notmatch '(?i)(actions|source|symbols|debug|database|rules|recipe)' } |
                Select-Object -First 1
        }

        if (-not $asset) {
            $assetNames = ($assets | ForEach-Object { $_.name }) -join ", "
            throw "No suitable Flyoobe EXE or application ZIP was found. Official release assets: $assetNames"
        }

        if (-not (Test-Path $DownloadPath)) {
            New-Item -ItemType Directory -Path $DownloadPath -Force | Out-Null
        }

        $target = Join-Path $DownloadPath $asset.name
        Write-WinUtilLog -Component "FlyOOBE" -Message "Selected official asset: $($asset.name)"
        Save-WinUtilFile -Uri $asset.browser_download_url -DestinationPath $target -ProgressCallback {
            param($percent)
            Step-WinUtilJob -Status "Downloading Flyoobe ($percent%)" -Percent $percent
        }

        if ([IO.Path]::GetExtension($target) -ieq ".exe") {
            $exePath = $target
        } else {
            $extract = Join-Path $sync.winutildir "FlyOOBE"
            if (Test-Path $extract) {
                Remove-Item $extract -Recurse -Force
            }
            New-Item -ItemType Directory -Path $extract -Force | Out-Null
            Expand-Archive -Path $target -DestinationPath $extract -Force

            # Try known application names first, then any executable inside the selected app archive.
            $exe = Get-ChildItem -Path $extract -File -Recurse |
                Where-Object { $_.Name -in @("Flyoobe.exe", "FlyOOBE.exe", "Flyby11.exe") } |
                Select-Object -First 1

            if (-not $exe) {
                $exe = Get-ChildItem -Path $extract -Filter "*.exe" -File -Recurse |
                    Select-Object -First 1
            }

            if (-not $exe) {
                $contents = Get-ChildItem -Path $extract -File -Recurse |
                    Select-Object -First 40 -ExpandProperty FullName |
                    ForEach-Object { $_.Substring($extract.Length).TrimStart('\','/') }
                $contentSummary = if ($contents) { $contents -join ", " } else { "(archive was empty)" }
                throw "The selected release asset '$($asset.name)' did not contain an EXE. Extracted files: $contentSummary. Open the official release page to inspect the new packaging: https://github.com/builtbybel/FlyOOBE/releases/latest"
            }

            $exePath = $exe.FullName
        }

        Step-WinUtilJob -Status "Launching Flyoobe" -Percent 100
        Start-Process -FilePath $exePath
        Write-WinUtilLog -Component "FlyOOBE" -Message "Flyoobe launched from the official builtbybel/FlyOOBE release."
    }
}
