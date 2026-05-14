function Test-DeploymentPrereqs {

    if (!(Test-Path "$PSScriptRoot\..\config.json")) {
        throw "Missing config.json"
    }

    if (!(Test-Path "$PSScriptRoot\..\Packages")) {
        throw "Missing Packages folder"
    }
}

Export-ModuleMember -Function Test-DeploymentPrereqs

function Test-WinRMTrust {

    try {
        $result = Test-WSMan -ComputerName "localhost" -ErrorAction Stop

        return [PSCustomObject]@{
            Success = $true
            Message = "WinRM healthy"
        }
    }
    catch {
        return [PSCustomObject]@{
            Success = $false
            Message = $_.Exception.Message
        }
    }
}

function Test-TargetReachable {
    param($Computer)

    if (Test-Connection $Computer -Count 1 -Quiet) {
        return @{ Success = $true }
    }

    return @{ Success = $false; Message = "No ping response" }
}

Export-ModuleMember -Function Test-WinRMTrust, Test-TargetReachable