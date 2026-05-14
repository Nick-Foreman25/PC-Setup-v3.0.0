function Set-PowerConfiguration {

    powercfg -change -standby-timeout-ac 0
    powercfg -change -monitor-timeout-ac 0
    powercfg -change -hibernate-timeout-ac 0
}

Export-ModuleMember -Function Set-PowerConfiguration