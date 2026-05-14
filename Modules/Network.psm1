function Disable-IPv6 {

    Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | ForEach-Object {

        Disable-NetAdapterBinding -Name $_.Name -ComponentID ms_tcpip6 -Confirm:$false
    }
}

function Reset-Winsock {

    netsh winsock reset
}

function Enable-RDP {

    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
}

Export-ModuleMember -Function Disable-IPv6, Reset-Winsock, Enable-RDP