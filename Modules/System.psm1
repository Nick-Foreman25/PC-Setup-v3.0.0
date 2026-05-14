function Get-SystemInventory {
    Get-ComputerInfo | Select-Object CsName, WindowsVersion, OsBuildNumber
}

function Test-SystemReadiness {

    $issues = @()

    if ((Get-Service WinRM).Status -ne "Running") {
        $issues += "WinRM not running"
    }

    return $issues
}

Export-ModuleMember -Function *


function Set-SystemBaseline {
    param(
        [string]$RoleName,
        [int]$Index = 1
    )

    $newName = "$RoleName-$Index"

    Rename-Computer -NewName $newName -Force
}