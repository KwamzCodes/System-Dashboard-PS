# BUILDING A REAL-TIME SYSTEM HEALTH DASHBOARD WITH POWERSHELL, HTML, AND CSS USING WINDOWS VM

### Introduction

In today’s fast paced IT-world, ensuring system reliability is not merely an option - it is crucial for mission success. Downtime and unnoticed errors can cause the company or organisation a significant loss in time, money and reputation. The System Health Dashboard was developed to address these issues by providing a real-time, automated monitoring solution that collects crucial system metrics such as CPU usage, memory utilisation, disk health, uptime, network status and critical event logs. These metrics are displayed in an interactive HTML interface featuring a dark blue futuristic design. This dashboard offers immediate visual insights and will be very useful making swift decision makings, troubleshooting a problem or just observing performance trends. It operates seamlessly through  Windows Task Scheduler, ensuring that you get accurate and updated data. By emerging PowerShell scripting, HTML/CSS design and automation, I have not only demonstrated techincal skill but also the ability to create effective, real-world IT solutions that can simplify the work of system administrators.

### Tools & Technologies

- PowerShell (scripting & data collection)
- HTML & CSS (frontend presentation and styling)
- Windows Task Sheduler (automation)
- Visual Studio Code (code editor)
- Web Browser  (Chrome, Edge) for testing HTML

### System Requirements

- Windows 10/11
- PowerShell 5
- Chrome / Edge

### Step-by-Step implementation

1. **Planning the Dashboard**

Planning the dashboard took a bit of time and heavy reasoning. There are many system health metrics but my goal was to provide the key ones - CPU, memory, disk, uptime, network, and event logs. My focus was on real-time accuracy and easy readability. I gave the dashboard a futuristic dark blue theme to make the data visually appealing. I separated the Powershell script, HTML and CSS into different files to make the project maintainable. Lastly, I automated the script via Task Scheduler to ensure regular updates without manual intervention.

1. **Gathering System Data with PowerShell**

In Powershell, I was able to derive all the system metrics - these include the following:

- **HostName**: shows the name that identifies your computer in a local network

```powershell
$env:COMPUTERNAME
```

- **OSName:** shows what Operating System you are using

```powershell
$OSInformation = Get-CimInstance - ClassName Win32_OperatingSystem
$OSname = $OSInformation.Caption.Trim()
```

- **OSVersion:** shows the version of OS you are using

```powershell
(Get-CimInstance -ClassName Win32_OperatingSystem).Version
```

- **OSBuild number:** a specific identifier for the version of your OS

```powershell
(Get-CimInstance -ClassName Win32_OperatingSystem).BuildNumber
```

- **CPU Load Percentage:** shows you how much the CPU is currently in use

```powershell
(Get-CimInstance Win32_Processor).LoadPercentage
```

- **CPU Name(Model):** Identifies the exact CPU chip

```powershell
(Get-CimInstance Win32_Processor).Name
```

- **Number of Cores:** Finds the physical processing power of the computer

```powershell
(Get-CimInstance Win32_Processor).NumberOfCores
```

- **Number of Logical Processors:** Finds the multitasking capacity of the CPU

```powershell
(Get-CimInstance Win32_Processor).NumberOfLogicalProcessors
```

- **Total Physical Memory:** The total installed RAM on your system

```powershell
$totalMemory = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB
**I round this figure to give a concise result**
```

- **Available Memory:** Determines how many RAM is currently available (free space)

```powershell
$freeMemory = (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory/1MB
**I round this figure to give a concise result**
```

To dive deeper - check source code.

![Image 08-08-2025 at 18.11.jpeg](Screenshots/Image_08-08-2025_at_18.11.jpeg)

### Exporting Data to HTML

 In HTML, I created placholders to accept the values from pwsh. I made sure to get the content of the html file in powershell by using this syntax:

```powershell
$html = Get-Content "C:\Users\Mikel\Desktop\index.html" -Raw
```

**Get-Content:** gets the data from the html file

**-Raw:** makes sure to get the content in the exact form, unedited, unmodified.

After getting the contents in HTML (the placeholders), I assigned the various system metrics data to each placeholder. After replacing the values. I exported the HTML file to the output file. 

Syntax:

```powershell
$html | Out-File "reportFile" -Encoding utf8
```

**reportFile:** is the output file, that renders script in a web browser.

![Image 08-08-2025 at 18.11.jpeg](Screenshots/Image_08-08-2025_at_18.11%201.jpeg)

### Styling with CSS

I created a separated CSS file and linked it to the HTML file using this syntax:

```html
<link rel="stylesheet" href="style.css"
```

In the CSS file, I styled the page to my preference. I animated the background and gave it a dark-blue futuristic theme.

![Image 08-08-2025 at 18.17.jpeg](Screenshots/Image_08-08-2025_at_18.17.jpeg)

### Automation with Task Scheduler

- In my task scheduler, under the actions section in the top right panel. I chose **“Create Basic Task”**

![Image 08-08-2025 at 18.21.jpeg](Screenshots/Image_08-08-2025_at_18.21.jpeg)

- In the “Create Basic Task” menu , I gave the script I want to automate a name.

![Image 08-08-2025 at 18.23.jpeg](Screenshots/Image_08-08-2025_at_18.23.jpeg)

- Now in the “Trigger” menu, I was asked when i want to start the automation. I chose daily to always get real-time and updated data. Since I chose daily, I set the time to when the automation should start.

![Image 08-08-2025 at 18.27.jpeg](Screenshots/Image_08-08-2025_at_18.27.jpeg)

![Image 08-08-2025 at 18.29.jpeg](Screenshots/Image_08-08-2025_at_18.29.jpeg)

- The “Action” menu is what you want the task to do, I chose to “start a program” since we are dealing with a script here.

![Image 08-08-2025 at 18.31.jpeg](Screenshots/Image_08-08-2025_at_18.31.jpeg)

- In the “Start a Program” menu, i entered Powershell as the script I want to run. In the “Add arguments” text bar, I wrote a script to bypass or ignore every restrictions to be able to run the script successfully.

Syntax:

```powershell
-ExcecutionPolicy Bypass -File "path to HTML file"
```

![Image 08-08-2025 at 18.40.jpeg](Screenshots/Image_08-08-2025_at_18.40.jpeg)

- The final part is the summary menu which shows you want you have done so far. I was okay with it and clicked on **“Finish”**

![Image 08-08-2025 at 18.40 (1).jpeg](Screenshots/Image_08-08-2025_at_18.40_(1).jpeg)

In my task creation, I wasn't  given an option to set a time interval for the task to be repeated. So I after creating the task, I located the file and navigated to the Trigger section on the top panel. In the Trigger menu I clicked on Edit. It opened a menu as shown in the image below:

![Image 08-08-2025 at 18.52.jpeg](Screenshots/Image_08-08-2025_at_18.52.jpeg)

I checked “Repeat task every” and set it 15mins. This means my script will run every 15 mins.

### Testing

Now to see if the task I created was successfully working, i had to manually run the task. 

I located my file and clicked “Run” in the actions panel on the right side.

![Image 08-08-2025 at 18.55.jpeg](Screenshots/Image_08-08-2025_at_18.55.jpeg)

My script run successfully as expected!!

### FINAL RESULT

![Image 08-08-2025 at 19.01.jpeg](Screenshots/Image_08-08-2025_at_19.01.jpeg)
