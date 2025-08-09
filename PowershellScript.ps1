#Create a file
$reportFile = "C:\Users\Mikel\Desktop\PChealthreport.html"
if (!(Test-Path $reportFile)) {
    New-Item -ItemType File $reportFile
}
else {
    Write-Host "File already exists"
}
#Get date
$date = (Get-Date).DateTime

#Get host name
$hostName = $env:COMPUTERNAME

#Get OS name
$OSInformation = Get-CimInstance -ClassName Win32_OperatingSystem
$OSname = $OSInformation.Caption.Trim()

#Get OS version
$osVersion = $OSInformation.Version

#Get OS Build
$osBuild = $OSInformation.BuildNumber

#Get CPU Usage Info
$CPUInfo = Get-CimInstance Win32_Processor
$LoadPercent = ($CPUInfo).LoadPercentage
$CPUName = ($CPUInfo).Name
$Cores = ($CPUInfo).NumberOfCores
$LogPro = ($CPUInfo).NumberOfLogicalProcessors

#Get Memory Usage Info 
$totalMemory = [Math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
$availMemory = [Math]::Round((Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB, 2)
$usedMemory = ($totalMemory) - ($availMemory)
$percentUsage = [Math]::Round(($usedMemory / $totalMemory) * 100, 2)

#Get Disk Health Info
$diskHealth = (Get-PhysicalDisk).HealthStatus
$diskC = Get-PSDrive -Name C
$CFree = [Math]::Round(($diskC).Free / 1GB, 1)
$diskD = Get-PSDrive -Name D
$DFree = [Math]::Round(($diskD).Free / 1MB, 1)
$diskE = Get-PSDrive -Name E
$EFree = [Math]::Round(($diskE).Free / 1MB, 1)
$diskF = Get-PSDrive -Name F
$FFree = [Math]::Round(($diskF).Free / 1MB, 1)
$CUsed = [Math]::Round(($diskC).Used / 1GB, 1)
$DUsed = [Math]::Round(($diskD).Used / 1MB, 1)
$EUsed = [Math]::Round(($diskE).Used / 1MB, 1)
$FUsed = [Math]::Round(($diskF).Used / 1GB, 1)

#Get System Uptime
$lastBootTime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
$uptime = (Get-Date) - ($lastBootTime)
$hrs = [Int]$uptime.TotalHours
$mins = [Int]$uptime.TotalMinutes
$uptime = "$hrs hr $mins min"

#Get Network Status
$IPAddress = (Get-NetIPAddress).IPv4Address
$NetworkName = (Get-NetAdapter).Name
$Status = (Get-NetAdapter).Status
$Speed = (Get-NetAdapter).LinkSpeed

#Get Event Logs
$log = (Get-EventLog -LogName System -Newest 1)
$Index = ($log).Index
$EntryType = ($log).EntryType
$Source = ($log).Source
$Instance = ($log).InstanceId
$Msg = ($log).Message
$TimeGen = ($log).TimeGenerated
$User = ($log).UserName
$Machine = ($log).MachineName
 
#Get content from html
$html = Get-Content "C:\Users\Mikel\Desktop\index.html" -Raw

#Replace values
$html = $html -replace "{{TIME}}", $date
$html = $html -replace "{{HOST}}", $hostName
$html = $html -replace "{{OS}}", $OSname
$html = $html -replace "{{VERSION}}", $osVersion
$html = $html -replace "{{BUILD}}", $osBuild
$html = $html -replace "{{LOAD}}", $LoadPercent
$html = $html -replace "{{MODEL}}", $CPUName
$html = $html -replace "{{CORES}}", $Cores
$html = $html -replace "{{LOG}}", $LogPro
$html = $html -replace "{{TPM}}", $totalMemory
$html = $html -replace "{{APM}}", $availMemory
$html = $html -replace "{{UPM}}", $usedMemory
$html = $html -replace "{{MUP}}", $percentUsage
$html = $html -replace "{{Health}}", $diskHealth
$html = $html -replace "{{C}}", $CFree
$html = $html -replace "{{D}}", $DFree
$html = $html -replace "{{E}}", $EFree
$html = $html -replace "{{F}}", $FFree
$html = $html -replace "{{CC}}", $CUsed
$html = $html -replace "{{DD}}", $DUsed
$html = $html -replace "{{EE}}", $EUsed
$html = $html -replace "{{FF}}", $FUsed
$html = $html -replace "{{LASTBOOT}}", $lastBootTime
$html = $html -replace "{{UPTIME}}", $uptime
$html = $html -replace "{{IP}}", $IPAddress
$html = $html -replace "{{NETNAME}}", $NetworkName
$html = $html -replace "{{STATUS}}", $Status
$html = $html -replace "{{SPEED}}", $Speed
$html = $html -replace "{{INDEX}}", $Index
$html = $html -replace "{{ENTRY}}", $EntryType
$html = $html -replace "{{SOURCE}}", $Source
$html = $html -replace "{{INSTANCE}}", $Instance
$html = $html -replace "{{MSG}}", $Msg
$html = $html -replace "{{TME}}", $TimeGen
$html = $html -replace "{{USER}}", $User
$html = $html -replace "{{MACNAME}}", $Machine




$html | Out-File "$reportFile" -Encoding utf8
Start-Process "C:\Users\Mikel\Desktop\PChealthreport.html"