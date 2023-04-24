//%attributes = {}
// setIfNotNullString (->varPtr ; value ; {enterable})
// mutates the varPtr-> only if value is not ""
// the third parameter is to set if the var should become lock after the mutuation (can be set to either true or false)

C_POINTER:C301($1; $varPtr)
C_TEXT:C284($2; $stringValue)
C_BOOLEAN:C305($3; $isEnterable)

Case of 
	: (Count parameters:C259=2)
		$varPtr:=$1
		$stringValue:=$2
		$isEnterable:=OBJECT Get enterable:C1067($varPtr->)  // the previous enterable state of the var
		
	: (Count parameters:C259=3)
		$varPtr:=$1
		$stringValue:=$2
		$isEnterable:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($stringValue#"")
	$varPtr->:=$stringValue
	OBJECT SET ENTERABLE:C238($varPtr->; $isEnterable)
End if 
