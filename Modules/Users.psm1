function Ensure-ECSUser {
    param(
        [pscredential]$Credential
    )

    $user = "emb-ecs"

    $password = $Credential.GetNetworkCredential().Password
    $secure = ConvertTo-SecureString $password -AsPlainText -Force

    if (Get-LocalUser -Name $user -ErrorAction SilentlyContinue) {
        Set-LocalUser -Name $user -Password $secure
        Set-LocalUser -Name $user -PasswordNeverExpires $true

        if (-not (Get-LocalGroupMember -Group "Administrators" | Where-Object {$_.Name -like "*$user"})) {
            Add-LocalGroupMember -Group "Administrators" -Member $user
        }

    } else {

        New-LocalUser -Name $user -Password $Password -PasswordNeverExpires
        Add-LocalGroupMember -Group "Administrators" -Member $user
    }
}

function Ensure-Administrator {
    param(
        [pscredential]$Credential
    )

    Enable-LocalUser -Name "Administrator"
    Set-LocalUser -Name "Administrator" -Password $Password
    Set-LocalUser -Name "Administrator" -PasswordNeverExpires $true
}

Export-ModuleMember -Function Ensure-ECSUser, Configure-Administrator