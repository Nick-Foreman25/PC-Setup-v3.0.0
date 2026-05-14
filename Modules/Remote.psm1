function Get-NetworkInventory {
    param([string]$Subnet)

    $base = $Subnet.Replace(".0/24","")

    $alive = @()

    1..254 | ForEach-Object {
        $ip = "$base.$_"
        if (Test-Connection $ip -Count 1 -Quiet -ErrorAction SilentlyContinue) {
            $alive += $ip
        }
    }

    return $alive
}

function Enable-RemoteDeployment {
    Enable-PSRemoting -Force
    Set-Item WSMan:\localhost\Client\TrustedHosts -Value "10.10.1.*" -Force
}

Export-ModuleMember -Function Get-NetworkInventory, Enable-RemoteDeployment