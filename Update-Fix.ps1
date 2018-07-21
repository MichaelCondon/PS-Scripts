#This script stops the necessary services and deletes the software distribution folder and Delivery Optimisation to resolve windows update issues
function checkServicesStatus(){ #checks whether the services are running and returns true if all are stopped
    [bool]$result
    $bits = Get-Service BITS | Select-Object Status
    $wu = Get-Service wuauserv | Select-Object Status
    $uso = Get-Service UsoSvc | Select-Object Status
    $dos = Get-Service DoSvc | Select-Object Status

    if($bits -eq "Stopped" -and $wu -eq "Stopped" -and $uso -eq "Stopped" -and $dos -eq "Stopped"){
        $result = $true
        return $result
    }
    else{
        $result = $false
        return $result
    }
}
#Stop the services required
Stop-Service BITS -F

Stop-Service wuauserv -F

Stop-Service UsoSvc -F

Stop-Service DoSvc -F

Write-Host "Stopping BITS, Update Orchestrator, Delivery Optimisation, and Update Services..."
Start-Sleep 5 #Wait just to make sure the services have completely shut off

if(checkServicesStatus -eq $true){
    Remove-Item -Path c:\windows\SoftwareDistribution -Recurse -Force
    Write-Host "SoftwareDistribution folder Successfully deleted"
    #restart services to be nice
    Start-Service BITS
    Start-Service wuauserv
    Start-Service UsoSvc
    Start-Service DoSvc
}