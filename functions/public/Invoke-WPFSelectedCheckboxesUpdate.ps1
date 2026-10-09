function Invoke-WPFSelectedCheckboxesUpdate ($type, $checkboxName) {
    $listName = switch -Regex ($checkboxName) {
        '^WPFInstall' { 'selectedApps' }
        '^WPFTweaks'  { 'selectedTweaks' }
        '^WPFToggle'  { 'selectedToggles' }
        '^WPFFeature' { 'selectedFeatures' }
        '^WPFAppx'    { 'selectedAppx' }
    }

    $selectionChanged = $false
    if ($type -eq "Add") {
        if (-not $sync.$listName.Contains($checkboxName)) {
            $sync.$listName.Add($checkboxName)
            $selectionChanged = $true
        }
    } else {
        $selectionChanged = $sync.$listName.Remove($checkboxName)
    }

    if ($listName -eq "selectedApps" -and $selectionChanged) {
        $sync.WPFselectedAppsButton.Content = "Selected Apps: $($sync.selectedApps.Count)"
        $sync.selectedAppsstackPanel.Children.Clear()
        $sync.selectedApps | Sort-Object | ForEach-Object {
            Add-SelectedAppsMenuItem -name $sync.configs.applicationsHashtable.$_.Content -key $_
        }
    }

    # Keep the Tweaks review panel synchronized with the selection list.
    if ($listName -eq "selectedTweaks" -and $selectionChanged -and $null -ne $sync.Form) {
        $countLabel = $sync.Form.FindName("WPFSelectedTweaksCount")
        $selectedList = $sync.Form.FindName("WPFSelectedTweaksList")
        $emptyLabel = $sync.Form.FindName("WPFNoTweaksSelected")
        if ($null -ne $countLabel) {
            $countLabel.Text = "$($sync.selectedTweaks.Count) tweaks will run"
        }
        if ($null -ne $selectedList) {
            $selectedList.Items.Clear()
            foreach ($selectedName in $sync.selectedTweaks) {
                $selectedTweak = $sync.configs.tweaks.PSObject.Properties[$selectedName]
                if ($null -ne $selectedTweak) {
                    $selectedList.Items.Add([string]$selectedTweak.Value.Content) | Out-Null
                }
            }
        }
        if ($null -ne $emptyLabel) {
            $emptyLabel.Visibility = if ($sync.selectedTweaks.Count -gt 0) {
                [Windows.Visibility]::Collapsed
            } else {
                [Windows.Visibility]::Visible
            }
        }
    }
}
