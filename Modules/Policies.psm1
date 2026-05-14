function Apply-LocalGPO {

    $LGPO = Join-Path $DeployRoot "LGPO\LGPO.exe"
$Backup = Join-Path $DeployRoot "LGPO\GPO_Backup"

    if ((Test-Path $LGPO) -and (Test-Path $Backup)) {

        & $LGPO /g $Backup
    }
}

Export-ModuleMember -Function Apply-LocalGPO