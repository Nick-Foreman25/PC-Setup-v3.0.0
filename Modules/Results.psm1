function New-DeploymentResult {
    param(
        [string]$Machine,
        [string]$Role,
        [string]$Stage,
        [string]$Status,
        [string]$Message,
        [datetime]$Timestamp = (Get-Date)
    )

    return [PSCustomObject]@{
        Machine   = $Machine
        Role      = $Role
        Stage     = $Stage
        Status    = $Status   # SUCCESS / FAILED / RETRY / ROLLBACK
        Message   = $Message
        Timestamp = $Timestamp
    }
}

Export-ModuleMember -Function New-DeploymentResult