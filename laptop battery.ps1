$hour=Get-WmiObject -Class Win32_Battery | Select-Object -Property EstimatedRunTime
$percentage=Get-WmiObject -Class Win32_Battery | Select-Object -Property EstimatedChargeRemaining
$remaining=[float]($hour.EstimatedRunTime/60)
$charge=[int]($percentage.EstimatedChargeRemaining)
Write-Host $remaining $charge