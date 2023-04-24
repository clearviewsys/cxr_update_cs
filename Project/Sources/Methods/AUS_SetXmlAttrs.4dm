//%attributes = {}
// ------------------------------------------------------------------------------
// Method: AUS_SetXmlAttrs
// Set the Attributes to a XML element
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 7/4/2019
// ------------------------------------------------------------------------------

C_TEXT:C284($0)
C_TEXT:C284($1; $root; $element)

C_POINTER:C301($2; $ptrArrAttrNames)
C_POINTER:C301($3; $ptrArrAttrValues)
C_LONGINT:C283($i)


Case of 
		
	: (Count parameters:C259=3)
		
		$root:=$1
		$ptrArrAttrNames:=$2
		$ptrArrAttrValues:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$element:=""

// Creates the new node into $root Node
If (($root#""))
	// Add Attributes to the element
	If (Size of array:C274($ptrArrAttrNames->)>0)
		
		For ($i; 1; Size of array:C274($ptrArrAttrNames->))
			DOM SET XML ATTRIBUTE:C866($root; $ptrArrAttrNames->{$i}; $ptrArrAttrValues->{$i})
		End for 
		
	End if 
	
End if 


$0:=$root

