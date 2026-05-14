function Install-SoftwarePackage {
    param(
        $Package,
        [string]$DeployRoot
    )

    $fullPath = Join-Path $DeployRoot $Package.path

    if (!(Test-Path $fullPath)) { return }

    $ext = [System.IO.Path]::GetExtension($fullPath)

    if ($ext -eq ".msi") {
        Start-Process "msiexec.exe" -ArgumentList "/i `"$fullPath`" $($Package.arguments)" -Wait
    } else {
        Start-Process $fullPath -ArgumentList $Package.arguments -Wait
    }
}