//%attributes = {}
// uses MoneyGram SOAP API to get list of cities in destination country

C_LONGINT:C283($1; $countryID)
C_TEXT:C284($2; $city)
C_TEXT:C284($3; $state)
C_OBJECT:C1216($0; $parameters; $result; $mgCredentials)

$countryID:=$1
$city:=$2

If (Count parameters:C259>2)
	$state:=$3
Else 
	$state:=""
End if 

$mgCredentials:=mgGetCredentials

If ($mgCredentials#Null:C1517)
	
	$parameters:=New object:C1471
	$parameters.Country:=$countryID
	$parameters.City:=$city
	$parameters.StateOfCountry:=$state
	
	$result:=mgSOAP_RunMethod($mgCredentials; "GetCityByCountry"; $parameters)
	
End if 

$0:=$result
