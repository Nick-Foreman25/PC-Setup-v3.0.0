function Remove-OneDrive {

    reg add "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f

    Stop-Process -Name "OneDrive" -ErrorAction SilentlyContinue

    Start-Sleep 2

    & "$env:SystemRoot\System32\OneDriveSetup.exe" /uninstall
}

Export-ModuleMember -Function Remove-OneDrive