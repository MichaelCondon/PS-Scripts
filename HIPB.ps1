#This script uses Troy Hunt's "Have I Been Pwned API"

Write-Host "This tool uses Troy Hunt's 'Have I Been Pwned' API to check if your email has been included in any know data breach"
Write-Host "The HIBP service is made publically available by Troy and the wonderful contributors at HIBP"
Write-Host "To learn more about the service and check your accounts in depth, please visit https://haveibeenpwned.com/"
Write-Host ""
$email = Read-Host "Please enter the email address you would like to check"

#By default powershell uses TLS 1.0, this forces it to use TLS 1.2, which is required by the HIBP API
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 


#Use a GET request against the API with the supplies email, set useragent as per API guidelines,and convert from json into a custom powershell object
$response = Invoke-WebRequest "https://haveibeenpwned.com/api/v2/breachedaccount/$email" -Method Get -UserAgent "Powershell ownage check" | ConvertFrom-Json

if($response.length -gt 0){
    foreach($i in $response){
        $name = $i.Name
        $domain = $i.Domain
        $breachDate = $i.BreachDate
        $desc = $i.Description -replace '<[^>]+>','' #Use regex to remove the HTML tags in the response
        
        Write-Host "------------"
        Write-Host "Service Name: $name"
        Write-Host "Domain: $domain"
        Write-Host "Date of Breach: $breachDate"
        Write-Host "Description: $desc"

        Write-Host "------------"
        Write-Host ""
        
    }
}
else{
 #TODO
}



