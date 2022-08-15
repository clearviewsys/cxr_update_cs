//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_SetPhone
// Generate the XML for Phone Numbers
// ------------------------------------------------------------------------------


C_TEXT:C284($1; $phones; $element; $location)
C_TEXT:C284($contactType; $commType)
C_TEXT:C284($number)

Case of 
		
	: (Count parameters:C259=1)
		
		$phones:=$1
		$contactType:="B"  // B-Branch address
		$commType:="B"  // B-Landline phone
		$number:=[Branches:70]BranchPhone:5
		
	: (Count parameters:C259=4)
		
		$phones:=$1
		$contactType:=$2
		$commType:=$3
		$number:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($number#"")
	GAML_SetPhone($phones; $contactType; $commType; $number)
	
End if 


If ([Branches:70]BranchFax:6#"")
	$contactType:="B"  // B-Branch address
	$commType:="A"  // A-Fax
	$number:=[Branches:70]BranchFax:6
	GAML_SetPhone($phones; $contactType; $commType; $number)
	
End if 


