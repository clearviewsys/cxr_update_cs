//%attributes = {}
// validateFieldsForTable(->[table])
// This method is called from within save button
// WARNING : IF YOU CALL THIS FROM THE INVOICE IT MAY SAVE THE WHOLE INVOICE
// BECAUSE IT VALIDATES THE TRANSACTION
// validateFieldsForTable( ->table; ignoreFieldConstraints)

C_POINTER:C301($1; $tablePtr)
C_BOOLEAN:C305($2; $ignoreFieldConstraints)
$ignoreFieldConstraints:=False:C215

Case of 
	: (Count parameters:C259=1)
		$tablePtr:=$1
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$ignoreFieldConstraints:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (validateTable($tablePtr; $ignoreFieldConstraints))
	SAVE RECORD:C53($TablePtr->)
	//UNLOAD RECORD($tablePtr->)  // to release the record // 
	OK:=1  //8/18/16 just in case
Else 
	REJECT:C38
	OK:=0
End if 
