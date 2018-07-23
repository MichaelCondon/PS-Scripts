

#This script uses Troy Hunt's "Have I Been Pwned API, information can be found at https://haveibeenpwned.com/API/v2
#I've written this to familiarise myself with how powershell handles basic web requests


Write-Host "This tool uses Troy Hunt's 'Have I Been Pwned' API to check if your email has been included in any know data breach"
Write-Host "The HIBP service is made publically available by Troy and the wonderful contributors at HIBP"
Write-Host "To learn more about the service and check your accounts in depth, please visit https://haveibeenpwned.com/"
Write-Host "As per the HIBP Privacy statement, the email you entered is only used to retrieve the address if it exists in the breach list, the address you search is never explicitly stored anywhere"

Write-Host ""
$email = Read-Host "Please enter the email address you would like to check"
Write-Host ""

#By default powershell uses TLS 1.0, this forces it to use TLS 1.2, which is required by the HIBP API
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


#Use a GET request against the API with the supplies email, set useragent as per API guidelines,and convert from json into a custom powershell object
#If the account has not been in any breaches, this returns a 404, which we have to catch
#This also allows us to gracefully handle the operation if the API goes down
try {
    $response = Invoke-WebRequest "https://haveibeenpwned.com/api/v2/breachedaccount/$email" -Method Get -UserAgent "Powershell ownage check" | ConvertFrom-Json
}
catch{
    $response = $_.Exception.Response.StatusCode.Value__
}
#If the response from the server was not a 404
#This solution is a bit heavy handed, I'll figure this out soon
if($response -ne "404"){
    Write-Host "Your email, $email has been found in the following breaches:" -ForegroundColor Red
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
 Write-Host "Your email, $email was not found in any known breaches." -ForegroundColor Green
}
Read-Host -Prompt "Press Enter to exit"


