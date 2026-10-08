function Invoke-WPFFlyOOBE {
    Start-WinUtilJob -Name "FlyOOBE" -Description "Downloading FlyOOBE" -Parameters @{
        DownloadPath = Join-Path $sync.winutildir "FlyOOBE-download"
    } -ScriptBlock {
        param($DownloadPath)

        $apiUri = "https://api.github.com/repos/builtbybel/FlyOOBE/releases/latest"
        Write-WinUtilLog -Component "FlyOOBE" -Message "Checking the official FlyOOBE release." 
        $release = Invoke-RestMethod -Uri $apiUri -Headers @{ Accept = "application/vnd.github+json" } -ErrorAction Stop

        $asset = $release.assets | Where-Object { $_.name -match '\.(exe|zip) | Select-Object -First 1
        if (-not $asset) {
            throw "No EXE or ZIP asset was found in the latest official FlyOOBE release."
        }

        $extension = [IO.Path]::GetExtension($asset.name)
        $target = "$DownloadPath$extension"
        Save-WinUtilFile -Uri $asset.browser_download_url -DestinationPath $target -ProgressCallback {
            param($percent)
            Step-WinUtilJob -Status "Downloading FlyOOBE ($percent%)" -Percent $percent
        }

        if ($extension -ieq ".exe") {
            Step-WinUtilJob -Status "Launching FlyOOBE" -Percent 100
            Start-Process -FilePath $target
        } else {
            $extract = Join-Path $sync.winutildir "FlyOOBE"
            if (Test-Path $extract) { Remove-Item $extract -Recurse -Force }
            Expand-Archive -Path $target -DestinationPath $extract -Force
            $exe = Get-ChildItem $extract -Filter "*.exe" -Recurse | Select-Object -First 1
            if (-not $exe) { throw "The FlyOOBE archive did not contain an executable." }
            Step-WinUtilJob -Status "Launching FlyOOBE" -Percent 100
            Start-Process -FilePath $exe.FullName
        }

        Write-WinUtilLog -Component "FlyOOBE" -Message "FlyOOBE launched from the official builtbybel/FlyOOBE release."
    }
}
 } | Select-Object -First 1
        if (-not $asset) {
            throw "No EXE or ZIP asset was found in the latest official FlyOOBE release."
        }

        $extension = [IO.Path]::GetExtension($asset.name)
        $target = "$DownloadPath$extension"
        Save-WinUtilFile -Uri $asset.browser_download_url -DestinationPath $target -ProgressCallback {
            param($percent)
            Step-WinUtilJob -Status "Downloading FlyOOBE ($percent%)" -Percent $percent
        }

        if ($extension -ieq ".exe") {
            Step-WinUtilJob -Status "Launching FlyOOBE" -Percent 100
            Start-Process -FilePath $target
        } else {
            $extract = Join-Path $sync.winutildir "FlyOOBE"
            if (Test-Path $extract) { Remove-Item $extract -Recurse -Force }
            Expand-Archive -Path $target -DestinationPath $extract -Force
            $exe = Get-ChildItem $extract -Filter "*.exe" -Recurse | Select-Object -First 1
            if (-not $exe) { throw "The FlyOOBE archive did not contain an executable." }
            Step-WinUtilJob -Status "Launching FlyOOBE" -Percent 100
            Start-Process -FilePath $exe.FullName
        }

        Write-WinUtilLog -Component "FlyOOBE" -Message "FlyOOBE launched from the official builtbybel/FlyOOBE release."
    }
}
