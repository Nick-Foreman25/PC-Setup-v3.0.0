
#DEPLOY CONTROLLER (ENTRYPOINT)


$DeployRoot = $PSScriptRoot

# ------------------------------
# IMPORT CORE MODULES
# ------------------------------
Import-Module "$DeployRoot\Modules\Logging.psm1"
Import-Module "$DeployRoot\Modules\Remote.psm1"
Import-Module "$DeployRoot\Modules\Orchestrator.psm1"
Import-Module "$DeployRoot\Modules\Validation.psm1"
Import-Module "$DeployRoot\Modules\State.psm1"
Import-Module "$DeployRoot\Modules\Pipeline.psm1"
# ------------------------------
# LOAD CONFIG
# ------------------------------
$config = Get-Content "$DeployRoot\config.json" | ConvertFrom-Json

Write-Log "=============================="
Write-Log "DEPLOYMENT CONTROLLER STARTED"
Write-Log "=============================="


#PRECHECK (CONTROLLER LEVEL)

try {
    Test-DeploymentPrereqs
}
catch {
    Write-Log "PRECHECK FAILED: $($_.Exception.Message)" "ERROR"
    throw
}


#NETWORK DISCOVERY

$machines = Get-NetworkInventory -Subnet $config.defaults.subnet

Write-Host "`nDiscovered Machines:`n"
$machines | ForEach-Object { Write-Host $_ }

Set-MachineInventory $machines


#ROLE SELECTION

$roles = $config.roles.PSObject.Properties.Name

Write-Host "`nAvailable Roles:"
for ($i = 0; $i -lt $roles.Count; $i++) {
    Write-Host "$($i + 1)) $($roles[$i])"
}

$choice = Read-Host "`nSelect Role Number"
$roleName = $roles[$choice - 1]

$role = $config.roles.$roleName

Write-Log "Selected Role: $roleName"


#TARGET RESOLUTION

$targets = Get-TargetsByRole `
    -RoleName $roleName `
    -Machines $machines `
    -Role $role

if (-not $targets -or $targets.Count -eq 0) {
    Write-Log "No targets found for role $roleName" "ERROR"
    throw "No target machines available"
}

Write-Host "`nTargets:"
$targets | ForEach-Object { Write-Host $_ }


#CREDENTIALS (CRITICAL PLACEMENT)

$ecsPassword = Read-Host "Emb-ECS Password" -AsSecureString
$adminPassword = Read-Host "Administrator Password" -AsSecureString


#EXECUTE ORCHESTRATION

Invoke-RoleDeployment `
    -Targets $targets `
    -Role $role `
    -Config $config `
    -DeployRoot $DeployRoot `
    -EcsPassword $ecsPassword `
    -AdminPassword $adminPassword


#END

Write-Log "DEPLOYMENT CONTROLLER FINISHED"