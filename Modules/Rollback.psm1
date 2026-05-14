function Invoke-Rollback {
    param($Computer)

    Invoke-Command -ComputerName $Computer -ScriptBlock {

        # Example rollback actions (extend as needed)
        Disable-PSRemoting -Force

        reg delete "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /f

        Write-Output "Rollback executed"
    }
}

Export-ModuleMember -Function Invoke-Rollback