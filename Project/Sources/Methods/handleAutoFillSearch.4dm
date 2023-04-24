//%attributes = {}
// handleAutoFillSearch (self; current form table; ->key;->value;->sortKey;->keyArr  `ary;->valueArray; {String:queryCommand})
// #review

C_TEXT:C284($search)
C_TEXT:C284(vRecNum; $8)
C_POINTER:C301($tablePtr; $self; $tablePtr; $keyPtr; $valuePtr; $sortKeyPtr; $arrKeyPtr; $arrValuePtr)
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7)
$self:=$1
$tablePtr:=$2
$keyPtr:=$3
$valuePtr:=$4
$sortKeyPtr:=$5
$arrKeyPtr:=$6
$arrValuePtr:=$7
// make sure you don't add $8 here cause it's inside the code

SET QUERY LIMIT:C395(<>queryLimit)

If (Form event code:C388=On Load:K2:1)
	//$self->:=""
	ARRAY TEXT:C222(arrValue; 0)
	ARRAY TEXT:C222(arrKey; 0)
End if 


If ((Form event code:C388=On Getting Focus:K2:7) | (Form event code:C388=On After Keystroke:K2:26))
	
	If (Form event code:C388=On After Keystroke:K2:26)
		$search:=Get edited text:C655
	Else 
		$search:=$self->
	End if 
	If (Count parameters:C259=7)
		ALL RECORDS:C47($tablePtr->)
	Else 
		executeMethodName($8)
	End if 
	
	QUERY SELECTION:C341($tablePtr->; $valuePtr->="@"+$search+"@"; *)
	QUERY SELECTION:C341($tablePtr->;  | ; $keyPtr->="@"+$search+"@")
	ARRAY TEXT:C222($arrKeyPtr->; 0)
	ARRAY TEXT:C222($arrValuePtr->; 0)
	
	REDRAW:C174($arrKeyPtr->)
	REDRAW:C174($arrValuePtr->)
	
	If (Records in selection:C76($tablePtr->)=0)
		BEEP:C151
	Else 
		ORDER BY:C49($tablePtr->; $sortKeyPtr->; >)
		SELECTION TO ARRAY:C260($keyPtr->; $arrKeyPtr->)
		SELECTION TO ARRAY:C260($valuePtr->; $arrValuePtr->)
		GOTO SELECTED RECORD:C245($tablePtr->; arrKey)
		$arrKeyPtr->:=1
		$arrValuePtr->:=1
		
	End if 
End if 
//
//If (Form event=On Data Change )
//GOTO SELECTED RECORD($tablePtr->;arrKey)
//End if 


If (Form event code:C388=On Losing Focus:K2:8)
	If (Records in selection:C76($tablePtr->)#0)
		$self->:=$keyPtr->
	Else 
		BEEP:C151
		//GOTO AREA(Self->)
	End if 
End if 

vRecNum:=String:C10(Records in selection:C76($tablePtr->))

SET QUERY LIMIT:C395(0)

