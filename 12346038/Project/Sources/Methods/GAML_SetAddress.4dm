//%attributes = {}
// GAML_SetAddress ($node; $ptrAddress; $ptrCity; $ptrProvince; $ptrZip; $ptrCountryCode)

C_TEXT:C284($1; $node; $tmp)
C_POINTER:C301($2; $ptrAddress)
C_POINTER:C301($3; $ptrCity)
C_POINTER:C301($4; $ptrProvince)
C_POINTER:C301($5; $ptrZip)
C_POINTER:C301($6; $ptrCountryCode)

Case of 
		
	: (Count parameters:C259=1)
		
		$node:=$1
		$ptrAddress:=->[Customers:3]Address:7
		$ptrCity:=->[Customers:3]City:8
		$ptrProvince:=->[Customers:3]Province:9
		$ptrZip:=->[Customers:3]PostalCode:10
		$ptrCountryCode:=->[Customers:3]CountryCode:113
		
		
	: (Count parameters:C259=6)
		$node:=$1
		$ptrAddress:=$2
		$ptrCity:=$3
		$ptrProvince:=$4
		$ptrZip:=$5
		$ptrCountryCode:=$6
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($addresses; $address; $element; $addressType)

If (($ptrCountryCode->=""))
	$ptrCountryCode->:=GAML_GetCountryCode([Customers:3]Country_obs:11)
End if 


If (($ptrAddress->#"") & ($ptrCity->#"") & ($ptrCountryCode->#""))
	
	$addresses:=GAML_CreateXMLNode($node; "addresses")
	$address:=GAML_CreateXMLNode($addresses; "address")
	
	// TODO: Was type: B validate Relianz
	If ([Customers:3]isCompany:41)
		$addressType:="C"
	Else 
		$addressType:="I"  // C-Business address
	End if 
	
	$ptrAddress->:=Replace string:C233($ptrAddress->; Char:C90(CR ASCII code:K15:14); "")
	$ptrAddress->:=Replace string:C233($ptrAddress->; Char:C90(LF ASCII code:K15:11); "")
	
	$element:=GAML_CreateXMLNode($address; "address_type"; ->$addressType)
	$element:=GAML_CreateXMLNode($address; "address"; $ptrAddress)
	$element:=GAML_CreateXMLNode($address; "city"; $ptrCity)
	$element:=GAML_CreateXMLNode($address; "zip"; $ptrZip)
	$element:=GAML_CreateXMLNode($address; "country_code"; $ptrCountryCode)
	// TODO: Confirm for Relianz. Hash requirement get rid state tag
	$element:=GAML_CreateXMLNode($address; "state"; $ptrProvince)
	
End if 
