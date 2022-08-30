//%attributes = {}
// setupObjectProperties($default;{$argument;{$callAssert}})
// object update the default object with the arguments
//
// Author: Wai-Kin

// Unit test written by @Wai-Kin
#DECLARE($defaultParam : Object; $argumentParam : Object; $callAssertParam : Boolean)->$result : Object

C_OBJECT:C1216($default)  // object of default values
C_OBJECT:C1216($argument)  // object from paramter
C_BOOLEAN:C305($callAssert)  // should ASSERT be called

$callAssert:=False:C215

Case of 
	: (Count parameters:C259=1)
		$default:=$defaultParam
		$argument:=New object:C1471
	: (Count parameters:C259=2)
		$default:=$defaultParam
		$argument:=$argumentParam
	: (Count parameters:C259=2)
		$default:=$defaultParam
		$argument:=$argumentParam
		$callAssert:=$callAssertParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($names; 0)  // property names of argument object
ARRAY LONGINT:C221($types; 0)  // property types of argument object (not used)
OB GET PROPERTY NAMES:C1232($argument; $names; $types)

C_LONGINT:C283($i)  // array indent
C_TEXT:C284($name)  // name of the property name
For ($i; 1; Size of array:C274($names))
	$name:=$names{$i}
	C_BOOLEAN:C305($isRightKey; $isRightType)  // checks the name and the type
	
	$isRightKey:=OB Is defined:C1231($default; $name)
	$isRightType:=OB Get type:C1230($default; $name)=OB Get type:C1230($argument; $name)
	
	If ($callAssert)
		ASSERT:C1129($isRightKey; "Property is not defined: "+$name)
		ASSERT:C1129($isRightType; "Wrong type for: "+$name)
	End if 
	
	If ($isRightKey & $isRightType)
		Case of 
			: (Value type:C1509($default[$name])=Is object:K8:27)
				If (Not:C34(\
					OB Instance of:C1731($default[$name]; 4D:C1709.Function) | \
					OB Instance of:C1731($default[$name]; 4D:C1709.Class)\
					))
					C_OBJECT:C1216($childDefault; $childArgument)  // setup variables for recusive call
					$childDefault:=OB Get:C1224($default; $name)
					$childArgument:=OB Get:C1224($argument; $name)
					If (OB Keys:C1719($default[$name]).length=0)
						OB SET:C1220($default; $name; OB Get:C1224($argument; $name))
					Else 
						OB SET:C1220($default; $name; utils_setupObjectProperties($childDefault; $childArgument))
					End if 
				Else 
					OB SET:C1220($default; $name; OB Get:C1224($argument; $name))
				End if 
			Else 
				OB SET:C1220($default; $name; OB Get:C1224($argument; $name))
		End case 
	End if 
End for 
$result:=$default