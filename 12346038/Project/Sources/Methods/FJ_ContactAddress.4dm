//%attributes = {}
C_TEXT:C284($1; $address; $2; $city; $3; $state; $4; $zip; $5; $countryCode)
C_TEXT:C284($0; $fullAddress)


Case of 
		
	: (Count parameters:C259=5)
		
		$address:=$1
		$city:=$2
		$state:=$3
		$zip:=$4
		$countryCode:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$fullAddress:=""

If ($address#"")
	$fullAddress:=$fullAddress+$address
Else 
	$fullAddress:=$fullAddress+" *MISSING*"
End if 

C_TEXT:C284($1; $address; $2; $city; $3; $state; $4; $zip; $5; $countryCode)
C_TEXT:C284($0; $fullAddress)


Case of 
		
	: (Count parameters:C259=5)
		
		$address:=$1
		$city:=$2
		$state:=$3
		$zip:=$4
		$countryCode:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$fullAddress:=""

If ($address#"")
	$address:=Replace string:C233($address; Char:C90(CR ASCII code:K15:14); "")
	$address:=Replace string:C233($address; Char:C90(LF ASCII code:K15:11); "")
	$fullAddress:=$fullAddress+FJ_Trim($address)
Else 
	$fullAddress:=$fullAddress+"*MISSING* ADDRESS"
End if 

If ($city#"")
	//$fullAddress:=$fullAddress+",\n"+FJ_Trim ($city)
	$fullAddress:=$fullAddress+","+FJ_Trim($city)
Else 
	$fullAddress:=$fullAddress+"*MISSING* CITY"
End if 

// FIJI Doesn't have states
If (False:C215)
	If ($state#"")
		$fullAddress:=$fullAddress+", "+$state
	Else 
		$fullAddress:=$fullAddress+" *MISSING*"
	End if 
End if 

// FIJI Doesn't have ZIP CODE o Postal Code
If (False:C215)
	If ($zip#"")
		$fullAddress:=$fullAddress+", "+$zip
	Else 
		$fullAddress:=$fullAddress+" *MISSING*"
	End if 
End if 

If ($countryCode#"")
	QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=$countryCode)
	//$fullAddress:=$fullAddress+",\n"+FJ_Trim ([Countries]CountryName)
	$fullAddress:=$fullAddress+","+FJ_Trim([Countries:62]CountryName:2)
Else 
	$fullAddress:=$fullAddress+"*MISSING* COUNTRY"
End if 

$0:=$fullAddress


