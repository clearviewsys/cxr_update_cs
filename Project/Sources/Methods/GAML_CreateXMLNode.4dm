//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_CreateXMLNode
// Creates a new XML Node in other node assigning the value if it is not empty 
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 8/9/2017
// ------------------------------------------------------------------------------

C_TEXT:C284($0)
C_TEXT:C284($1; $root; $element)
C_TEXT:C284($2; $nodeName; $value; $missingMsg)
C_POINTER:C301($3; $ptrValue)
C_BOOLEAN:C305($4; $required)


$value:=""
$required:=False:C215
$missingMsg:="*MISSING*"

Case of 
		
	: (Count parameters:C259=2)
		
		$root:=$1
		$nodeName:=$2
		$ptrValue:=->$value
		
	: (Count parameters:C259=3)
		
		$root:=$1
		$nodeName:=$2
		$ptrValue:=$3
		
	: (Count parameters:C259=4)
		
		$root:=$1
		$nodeName:=$2
		$ptrValue:=$3
		$required:=$4
		
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$element:=""

// Creates the new node into $root Node
If (($root#"") & ($nodeName#""))
	
	Case of 
			
		: (Type:C295($ptrValue->)#Is text:K8:3)
			
			If (String:C10($ptrValue->)#"")  // Value is not empty?
				$element:=DOM Create XML element:C865($root; $nodeName)
				DOM SET XML ELEMENT VALUE:C868($element; String:C10($ptrValue->))
			Else 
				If ($required)
					// Create the tag with the UNKNOWN-REQUIRED value
					$element:=DOM Create XML element:C865($root; $nodeName)
					DOM SET XML ELEMENT VALUE:C868($element; $missingMsg)
				End if 
				
			End if 
			
		: (Type:C295($ptrValue->)=Is text:K8:3)
			
			If (Count parameters:C259=2)  // Create only the element without value
				$element:=DOM Create XML element:C865($root; $nodeName)
			Else 
				
				If ($ptrValue->#"")  // Value is not empty?
					$element:=DOM Create XML element:C865($root; $nodeName)
					DOM SET XML ELEMENT VALUE:C868($element; $ptrValue->)
				Else 
					If ($required)
						// Create the tag with the *MISSING* value
						$element:=DOM Create XML element:C865($root; $nodeName)
						DOM SET XML ELEMENT VALUE:C868($element; $missingMsg)
					End if 
					
				End if 
			End if 
			
	End case 
	
End if 



$0:=$element

