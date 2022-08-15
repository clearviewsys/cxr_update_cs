//%attributes = {}

// Checks MoneyGram credentials by calling SOAP API and checking result
// We use GetCityByCountry SOAP method because we can narrow the result to one record only to get 
// smaller traffic going from MoneyGram Server back to us

C_OBJECT:C1216($1; $0; $mgCredentials; $parameters; $resultCities)
//C_BOOLEAN($0)

If (Count parameters:C259>0)
	$mgCredentials:=$1
Else 
	$mgCredentials:=mgGetCredentials
End if 

$parameters:=New object:C1471("Country"; "688"; "City"; "B")  // get all cities from Serbia which name begins with B - should return Belgrade only

$resultCities:=mgSOAP_RunMethod($mgCredentials; "GetCityByCountry"; $parameters)

$0:=$resultCities

//If ($resultCities.success)
//$0:=True
//Else 
//$0:=False
//End if 