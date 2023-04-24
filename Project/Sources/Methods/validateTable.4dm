//%attributes = {}
// validateTable (->table; {igoneFieldContraints}) : boolean 
// returns a boolean about validation

C_POINTER:C301($1; $tablePtr)
C_BOOLEAN:C305($0; $2; $ignoreFieldConstraints)

$ignoreFieldConstraints:=False:C215

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$ignoreFieldConstraints:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

checkInit
executeMethodName("validate"+Table name:C256($tablePtr))

If (Not:C34($ignoreFieldConstraints))
	checkFieldConstraintsForTable($tablePtr; False:C215)  // check all the field constraints for table (non conditional ones)
End if 

$0:=isValidationConfirmed


