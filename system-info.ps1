Write-Host "========================================="
Write-Host "SYSTEM INFORMATION TOOLKIT"
Write-Host "========================================="

Write-Host ""
Write-Host "Computer Name:"
hostname

Write-Host ""
Write-Host "Current User:"
whoami

Write-Host ""
Write-Host "Windows Version:"
$os = Get-CimInstance -ClassName Win32_OperatingSystem
Write-Host $os.Caption

Write-Host ""
Write-Host "System Uptime:"
$lastBoot = $os.LastBootUpTime
$uptime = New-TimeSpan -Start $lastBoot -End (Get-Date)
Write-Host "$($uptime.Days) days, $($uptime.Hours) hours, $($uptime.Minutes) minutes"

Write-Host ""
Write-Host "CPU Info:"
Get-CimInstance Win32_Processor |
Select-Object Name, NumberOfCores, NumberOfLogicalProcessors |
Format-Table -AutoSize

Write-Host ""
Write-Host "RAM Info:"
$ramBytes = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory
$ramGB = [math]::Round($ramBytes / 1GB, 2)
Write-Host "Total RAM: $ramGB GB"

Write-Host ""
Write-Host "Disk Info:"
Get-PSDrive -PSProvider FileSystem |
Select-Object Name,
@{Name="UsedGB";Expression={[math]::Round($_.Used/1GB,2)}},
@{Name="FreeGB";Expression={[math]::Round($_.Free/1GB,2)}} |
Format-Table -AutoSize

Write-Host ""
Write-Host "Network Adapters:"
Get-NetAdapter |
Select-Object Name, Status, LinkSpeed |
Format-Table -AutoSize

Write-Host ""
Write-Host "Top Processes by CPU:"
Get-Process |
Sort-Object CPU -Descending |
Select-Object -First 10 Name, CPU |
Format-Table -AutoSize

Write-Host ""
Write-Host "========================================="
Write-Host "System Info Collection Complete"
Write-Host "========================================="
