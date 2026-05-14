function Group-MachinesByRole {
    param(
        [array]$Machines,
        [object]$Config
    )

    $result = @{}

    foreach ($role in $Config.roles.PSObject.Properties.Name) {
        $result[$role] = @()
    }

    foreach ($m in $Machines) {

        if ($m -match "SERVER") { $result["ECSSERVER"] += $m }
        elseif ($m -match "POS") { $result["POS"] += $m }
        elseif ($m -match "KIOSK") { $result["KIOSK"] += $m }
        elseif ($m -match "RED") { $result["REDEMPTION"] += $m }
        elseif ($m -match "STANDBY") { $result["ECSSTANDBY"] += $m }
    }

    return $result
}

# ==============================
# ✅ THIS IS THE FUNCTION YOU WERE MISSING
# ==============================
function Get-TargetsByRole {
    param(
        [string]$RoleName,
        [array]$Machines,
        [object]$Role
    )

    # If role allows multiple machines, return all matches
    if ($Role.allowMultiple -eq $true) {

        return $Machines | Where-Object {
            $_ -match $RoleName
        }
    }

    # Otherwise return first match only
    return $Machines | Where-Object {
        $_ -match $RoleName
    } | Select-Object -First 1
}

function Set-MachineInventory {
    param($Machines)

    $Machines | Out-File "$PSScriptRoot\..\State\inventory.txt"
}

Export-ModuleMember -Function `
    Group-MachinesByRole,
    Get-TargetsByRole,
    Set-MachineInventory