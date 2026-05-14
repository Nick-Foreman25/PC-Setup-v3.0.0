$Global:LogFile = Join-Path $Global:DeployRoot "Logs\deploy.log"

function Write-Log {
    param($Message)

    $line = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') $Message"
    Add-Content $Global:LogFile $line
    Write-Host $line
}

Export-ModuleMember -Function Write-Log