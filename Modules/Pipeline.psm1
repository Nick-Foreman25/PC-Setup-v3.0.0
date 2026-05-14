function Invoke-DeploymentPipeline {

    param(
        [string]$Computer,
        [object]$Role,
        [object]$Config,
        [string]$DeployRoot,
        [securestring]$EcsPassword,
        [securestring]$AdminPassword
    )

    try {

        Write-Log "[$Computer] PRECHECK"

        $reachable = Test-TargetReachable -Computer $Computer

        if (-not $reachable.Success) {

            return [PSCustomObject]@{
                Computer = $Computer
                Status = "FAILED"
                Message = $reachable.Message
            }
        }

        Write-Log "[$Computer] DEPLOY"

        Invoke-Command -ComputerName $Computer -ScriptBlock {

            param($Role, $Config, $DeployRoot, $EcsPassword, $AdminPassword)

            Import-Module "$DeployRoot\Modules\Users.psm1"
            Import-Module "$DeployRoot\Modules\Network.psm1"
            Import-Module "$DeployRoot\Modules\Software.psm1"
            Import-Module "$DeployRoot\Modules\Features.psm1"
            Import-Module "$DeployRoot\Modules\Registry.psm1"
            Import-Module "$DeployRoot\Modules\Power.psm1"
            Import-Module "$DeployRoot\Modules\OneDrive.psm1"
            Import-Module "$DeployRoot\Modules\Policies.psm1"

            Ensure-ECSUser -Password $EcsPassword

            Configure-Administrator -Password $AdminPassword

            if ($Role.enableRDP) {
                Enable-RDP
            }

            if ($Config.defaults.disableIPv6) {
                Disable-IPv6
            }

            if ($Config.defaults.setPowerSettings) {
                Set-PowerConfiguration
            }

            if ($Config.defaults.removeOneDrive) {
                Remove-OneDrive
            }

            if ($Config.defaults.applyExplorerTweaks) {
                Import-ExplorerTweaks
            }

            if ($Config.defaults.applyFolderPrivacyTweaks) {
                Apply-PrivacyTweaks
            }

            if ($Config.defaults.disableXboxGameBar) {
                Remove-XboxGameBar
            }

            if ($Config.defaults.applyGPO) {
                Apply-LocalGPO
            }

            Install-WindowsFeatures -Features $Role.windowsFeatures

            foreach ($s in $Role.software) {

                Install-SoftwarePackage `
                    -Package $Config.softwarePackages.$s `
                    -DeployRoot $DeployRoot
            }

        } -ArgumentList $Role, $Config, $DeployRoot, $EcsPassword, $AdminPassword

        Write-Log "[$Computer] POSTCHECK"

        return [PSCustomObject]@{
            Computer = $Computer
            Status = "SUCCESS"
            Message = "Deployment completed"
        }
    }
    catch {

        return [PSCustomObject]@{
            Computer = $Computer
            Status = "FAILED"
            Message = $_.Exception.Message
        }
    }
}

Export-ModuleMember -Function Invoke-DeploymentPipeline