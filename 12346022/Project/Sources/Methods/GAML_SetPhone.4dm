//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_SetPhone
// Generate the XML for Phones
// ------------------------------------------------------------------------------


C_TEXT:C284($1; $node; $element; $location)
C_TEXT:C284($2; $contactType; $3; $commType; $4; $number; $5; $countryPrefix; $6; $extension; $7; $comments)


Case of 
		
	: (Count parameters:C259=4)
		
		$node:=$1
		$contactType:=$2
		$commType:=$3
		$number:=$4
		$countryPrefix:=""
		$extension:=""
		$comments:=""
		
	: (Count parameters:C259=5)
		
		$node:=$1
		$contactType:=$2
		$commType:=$3
		$number:=$4
		$countryPrefix:=$5
		$extension:=""
		$comments:=""
		
	: (Count parameters:C259=6)
		
		$node:=$1
		$contactType:=$2
		$commType:=$3
		$number:=$4
		$countryPrefix:=$5
		$extension:=$6
		$comments:=""
		
	: (Count parameters:C259=7)
		
		$node:=$1
		$contactType:=$2
		$commType:=$3
		$number:=$4
		$countryPrefix:=$5
		$extension:=$6
		$comments:=$7
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($number#"")
	
	$element:=GAML_CreateXMLNode($node; "tph_contact_type"; ->$contactType)  // B-Branch address, C-Business address
	$element:=GAML_CreateXMLNode($node; "tph_communication_type"; ->$commType)
	$element:=GAML_CreateXMLNode($node; "tph_country_prefix"; ->$countryPrefix)
	$element:=GAML_CreateXMLNode($node; "tph_number"; ->$number)
	$element:=GAML_CreateXMLNode($node; "tph_extension"; ->$extension)
	$element:=GAML_CreateXMLNode($node; "comments"; ->$comments)
End if 

