function Export-DeploymentReport {
    param([array]$Results)

    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

    $jsonPath = "$PSScriptRoot\..\Logs\deployment_$timestamp.json"
    $csvPath  = "$PSScriptRoot\..\Logs\deployment_$timestamp.csv"

    $Results | ConvertTo-Json -Depth 5 | Out-File $jsonPath
    $Results | Export-Csv -NoTypeInformation -Path $csvPath

    Write-Host "Report saved:"
    Write-Host $jsonPath
    Write-Host $csvPath
}

Export-ModuleMember -Function Export-DeploymentReport