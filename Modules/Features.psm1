function Install-WindowsFeatures {
    param(
        [array]$Features
    )

    foreach ($feature in $Features) {

        $state = Get-WindowsOptionalFeature -Online -FeatureName $feature

        if ($state.State -ne "Enabled") {

            Enable-WindowsOptionalFeature -Online -FeatureName $feature -All -NoRestart
        }
    }
}

Export-ModuleMember -Function Install-WindowsFeatures