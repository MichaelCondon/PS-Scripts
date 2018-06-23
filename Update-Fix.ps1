#This script stops the necessary services and deletes the software distribution folder and Delivery Optimisation to resolve windows update issues
function checkServicesStatus(){ #checks whether the services are running and returns true if all are stopped
    
    [bool]$result
    $bits = Get-Service BITS | Select-Object Status
    $wu = Get-Service wuauserv | Select-Object Status
    $uso = Get-Service UsoSvc | Select-Object Status

    if($bits -eq "Stopped" -and $wu -eq "Stopped" -and $uso -eq "Stopped"){
        $result = $true
        return $result
    }
    else{
        $result = $false
        return $result
    }
}



Stop-Service BITS -F

Stop-Service wuauserv -F

Stop-Service UsoSvc -F


Write-Host "Stopping BITS, Update Orchestrator and Update Services..."
Start-Sleep 5


# Write-Output Get-Service BITS | Select-Object Status
# Write-Output Get-Service wuauserv | Select-Object Status

if(checkServicesStatus -eq $true){
    Remove-Item -Path c:\windows\SoftwareDistribution -Recurse -Force
    Write-Host "SoftwareDistribution Successfully deleted"
    Start-Service BITS
    Start-Service wuauserv 
    Start-Service UsoSvc
}


