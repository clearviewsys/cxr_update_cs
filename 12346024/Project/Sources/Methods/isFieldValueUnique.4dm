//%attributes = {}
// isFieldValueUnique (self; ->fieldPtr;message)
// seeAlso: isFieldUnique 

If (False:C215)  // see also ; the following method is left in if (false) in case of future refactoring of method name
	handleCustomerUniqueFieldOM
End if 

C_POINTER:C301($self; $1)
C_POINTER:C301($fieldPtr; $2; $tablePtr)
C_TEXT:C284($alert; $3)
C_BOOLEAN:C305($0)

$0:=False:C215

$alert:=""
Case of 
	: (Count parameters:C259=2)
		$self:=$1
		$fieldPtr:=$2
	: (Count parameters:C259=3)
		$self:=$1
		$fieldPtr:=$2
		$alert:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tablePtr:=getTablePtrFromFieldPtr($fieldPtr)

C_LONGINT:C283($found)
SET QUERY DESTINATION:C396(Into variable:K19:4; $found)

If (Is new record:C668($tablePtr->)=True:C214)
	QUERY:C277($tablePtr->; $fieldPtr->=$self->)
Else   // modified record
	// check only if the value has changed
	If (($Self->#Old:C35($fieldPtr->)) & ($self->#""))  // if the value of the self is different from what is previously saved in the database, then we search
		// otherwise, there's no point searching because we will find the same record in the database and we think we are adding a duplicate value but it's actually the same exact record
		QUERY:C277($tablePtr->; $fieldPtr->=$self->)
	End if 
End if 


If ($found>=1)
	$0:=True:C214
	$self->:=$self->+"!!!"
	GOTO OBJECT:C206($Self->)  // may not be a good idea as 
	myAlert($alert)
Else 
	$0:=False:C215
End if 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
