//%attributes = {}
// populateDD (->fieldPtr)
// Call this method to fill a dropdown menu values in a field

C_POINTER:C301($self; $fieldPtr; $tablePtr; $1)
C_LONGINT:C283($fieldNum; $tableNum; $n)
C_TEXT:C284($varName)

$self:=OBJECT Get pointer:C1124(Object current:K67:2)

Case of 
	: (Count parameters:C259=0)
		$fieldPtr:=->[Branches:70]BranchID:1
		
	: (Count parameters:C259=1)
		$fieldPtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 



RESOLVE POINTER:C394($fieldPtr; $varName; $tableNum; $fieldNum)
$tablePtr:=Table:C252($tableNum)


If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145($tablePtr->)
	ALL RECORDS:C47($tablePtr->)
	$n:=Records in selection:C76($tablePtr->)
	//SELECTION TO ARRAY($fieldPtr->;$self->)
	DISTINCT VALUES:C339($fieldPtr->; $self->)
	SORT ARRAY:C229($self->)
	INSERT IN ARRAY:C227($self->; 1)
End if 

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))  // something else has to happen 
	SET TIMER:C645(1)
	POST OUTSIDE CALL:C329(Current process:C322)
End if 

