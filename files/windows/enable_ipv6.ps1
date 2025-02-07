$path = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$name = "DisabledComponents"
$targetValue = "0"

if ( -Not ( Test-Path $path ) ) {
    Write-Host "Key $path not found."
    return
}

$currentValue = Get-ItemProperty -Path $path -Name $name -ErrorAction SilentlyContinue
if ( -Not ( $currentValue ) ) {
    Write-Host "Value of $name not found."
    return
}

$value = $currentValue.$name

if ($value -eq $targetValue) {
    Write-Host "Value of $name is already set to $targetValue."
    return
}

Write-Host "Value of $name is $value."

try {
    Set-ItemProperty -Path $path -Name $name -Value $targetValue -ErrorAction Stop
} catch {
    Write-Host "Failed to set value of $name."
    Write-Host "Run the script with admin privileges."
    Write-Host "Reboot required for the changes to take effect."
    return
}

Write-Host "Value changed to $targetValue."
