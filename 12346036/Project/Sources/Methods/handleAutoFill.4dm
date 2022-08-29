//%attributes = {}
// handleAutoFill (->var; ->table;->field;->listArray)
// ex : handleAutoFill(self; ->[currencies];->[currencies]ticker)

C_POINTER:C301($1; $2; $3; $4; $varPtr; $tablePtr; $fieldPtr; $arrPtr)
C_TEXT:C284($variable)

Case of 
	: (Count parameters:C259=4)
		$varPtr:=$1
		$tablePtr:=$2
		$fieldPtr:=$3
		$arrPtr:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$variable:=$varPtr->

If (Form event code:C388=On Load:K2:1)
	$varPtr->:=""
	$variable:=""
End if 

If (Form event code:C388=On Getting Focus:K2:7)
	OBJECT SET VISIBLE:C603($arrPtr->; True:C214)
End if 

If ((Form event code:C388=On Getting Focus:K2:7) | (Form event code:C388=On After Keystroke:K2:26))
	$variable:=Get edited text:C655
	QUERY:C277($tablePtr->; $fieldPtr->=$variable+"@")
	
	ARRAY TEXT:C222($arrPtr->; 0)
	
	REDRAW:C174($arrPtr->)
	If (Records in selection:C76($tablePtr->)=0)
		BEEP:C151
	Else 
		SELECTION TO ARRAY:C260($fieldPtr->; $arrPtr->)
		$arrPtr->:=1
	End if 
End if 

If (Form event code:C388=On Losing Focus:K2:8)
	If (Records in selection:C76($tablePtr->)#0)
		FIRST RECORD:C50($tablePtr->)
		$varPtr->:=$fieldPtr->
		OBJECT SET VISIBLE:C603($arrPtr->; False:C215)
	Else 
		BEEP:C151
		GOTO OBJECT:C206($tablePtr->)
	End if 
End if 