function Import-ExplorerTweaks {

    $regFile = Join-Path $DeployRoot "Tweaks\explorer_tweaks.reg"

    if (Test-Path $regFile) {
        reg import $regFile
    }
}

function Apply-PrivacyTweaks {

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Value 0

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Value 0

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_AccountNotifications" -Value 0
}

function Remove-XboxGameBar {

    Get-AppxPackage *Microsoft.XboxGamingOverlay* | Remove-AppxPackage
}

Export-ModuleMember -Function Import-ExplorerTweaks, Apply-PrivacyTweaks, Remove-XboxGameBar