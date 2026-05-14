function Invoke-RoleDeployment {

    param(
        [array]$Targets,
        [object]$Role,
        [object]$Config,
        [string]$DeployRoot,
        [securestring]$EcsPassword,
        [securestring]$AdminPassword
    )

    $results = @()

    foreach ($t in $Targets) {

        $attempt = 0
        $maxRetries = 2
        $success = $false

        while (-not $success -and $attempt -lt $maxRetries) {

            $attempt++

            try {

                Write-Log "[$t] Attempt $attempt starting"

                $r = Invoke-DeploymentPipeline `
                    -Computer $t `
                    -Role $Role `
                    -Config $Config `
                    -DeployRoot $DeployRoot `
                    -EcsPassword $EcsPassword `
                    -AdminPassword $AdminPassword

                $results += $r

                if ($r.Status -eq "SUCCESS") {

                    $success = $true

                    Write-Log "[$t] Deployment successful"
                }
                else {

                    throw $r.Message
                }
            }
            catch {

                Write-Log "[$t] Attempt $attempt failed: $_" "ERROR"

                Start-Sleep 5
            }
        }

        if (-not $success) {

            Write-Log "[$t] FAILED after retries" "ERROR"
        }
    }

    Export-DeploymentReport -Results $results
}

Export-ModuleMember -Function Invoke-RoleDeployment