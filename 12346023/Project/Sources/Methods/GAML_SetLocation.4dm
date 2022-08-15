//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_SetLocation
// Generate the XML for Location
// ------------------------------------------------------------------------------


C_TEXT:C284($1; $root; $element; $location)
C_TEXT:C284($addressType; $2; $address; $3; $city; $4; $zip; $5; $countryCode; $6; $state; $7)

Case of 
	: (Count parameters:C259=1)
		
		$root:=$1
		
		QUERY:C277([Branches:70]; [Branches:70]BranchID:1=getBranchID)
		$addressType:="B"
		
		If ([Branches:70]Address:3#"")
			$address:=[Branches:70]Address:3
		Else 
			$address:=""
		End if 
		
		
		If ([Branches:70]City:4#"")
			$city:=[Branches:70]City:4
		Else 
			$city:=""
		End if 
		
		
		If ([Branches:70]PostalCode:11#"")
			$zip:=[Branches:70]PostalCode:11
		Else 
			$zip:=""
		End if 
		
		If ([Branches:70]CountryCode:12#"")
			$countryCode:=[Branches:70]CountryCode:12
		Else 
			$countryCode:=""
		End if 
		
		
	: (Count parameters:C259=7)
		$root:=$1
		$addressType:=$2
		$address:=$3
		$city:=$4
		$zip:=$5
		$countryCode:=$6
		$state:=$7
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (($address#"") & ($city#"") & ($zip#"") & ($countryCode#""))
	$location:=GAML_CreateXMLNode($root; "location")
	
	$address:=Replace string:C233($address; Char:C90(CR ASCII code:K15:14); "")
	$address:=Replace string:C233($address; Char:C90(LF ASCII code:K15:11); "")
	
	$element:=GAML_CreateXMLNode($location; "address_type"; ->$addressType)
	$element:=GAML_CreateXMLNode($location; "address"; ->$address)
	$element:=GAML_CreateXMLNode($location; "city"; ->$city)
	$element:=GAML_CreateXMLNode($location; "zip"; ->$zip)
	$element:=GAML_CreateXMLNode($location; "country_code"; ->$countryCode)
	$element:=GAML_CreateXMLNode($location; "state"; ->$state)
End if 

