<#
.NOTES
    Project Author : Mohamed Babaamer
    Based On       : WinUtil by Chris Titus Tech
    Runspace Author: @DeveloperDurp
    Project GitHub  : https://github.com/MohamedBabaamer/WinUtilX
    Upstream       : https://github.com/ChrisTitusTech/winutil
    Version        : #{replaceme}
#>

param (
    [string]$Config,
    [ValidateSet("Standard", "Minimal", "Advanced", "")]
    [string]$Preset,
    [switch]$Offline
)

function Test-WinUtilOwnsFileProcess {
    <#
        .SYNOPSIS
            Whether the current process was launched with this script as its file target
    #>