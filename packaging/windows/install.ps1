# install.ps1
param (
    [string]$ConfigPath = "C:\ProgramData\tunnelvision\client.yaml",
    [string]$BinaryPath = "C:\Program Files\tunnelvision\tunnelvision.exe"
)

$Action = New-ScheduledTaskAction -Execute $BinaryPath -Argument "client --config `"$ConfigPath`""
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

Register-ScheduledTask -TaskName "tunnelvision-client" -Action $Action -Trigger $Trigger -Principal $Principal -Settings $Settings -Force
Write-Host "tunnelvision-client task registered successfully."
