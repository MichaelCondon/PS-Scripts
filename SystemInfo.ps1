#CPU information
$cpu = Get-WmiObject -Class win32_processor | Select-Object Caption, Description, NumberofCores, Name, Manufacturer, MaxClockSpeed, NumberOfLogicalProcessors;

$caption = $cpu.Caption;
$desc = $cpu.Description;
$noc = $cpu.NumberofCores;
$name = $cpu.Name;
$man = $cpu.Manufacturer;
$speed = $cpu.MaxClockSpeed;
$lNoc = $cpu.NumberOfLogicalProcessors;


#Windows Information
$pcOS = get-wmiobject win32_operatingsystem -computer localhost | Select-Object csname,caption,servicepackmajorversion #select required OS information

$csname = $pcOS.csname;
$pcCaption = $pcOS.caption;
$servicePack = $pcOS.servicepackmajorversion;
$version = (Get-CimInstance Win32_OperatingSystem).version; #Gets the build number of the users windows install

Write-Output "SYSTEM INFO";
Write-Output "---------------";
Write-Output "CPU Information";
Write-Output "---------------";
Write-Output "Name: $name";
Write-Output "Max Clock Speed: $speed Mhz";
Write-Output "Cores: $noc";
Write-Output "Virtual Cores: $lNoc";
Write-Output "Description: $desc";
Write-Output "---------------";
Write-Output "Date and Time";
Write-Output "---------------";
#gets the system date
$date = Get-Date;
Write-Output "The current system date is $date" ;
Write-Output "---------------";
Write-Output "Windows Information";
Write-Output "---------------";
Write-Output "PC Name: $csname";
Write-Output "Windows SKU: $pcCaption";
Write-Output "Service Pack: $servicePack";
Write-Output "Your PC is running Windows build $version";