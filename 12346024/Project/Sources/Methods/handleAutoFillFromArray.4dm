//%attributes = {}
// handleAutoFillSearch (self; ->valueArray; )
C_TEXT:C284($search)
C_TEXT:C284(vRecNum)
C_POINTER:C301($tablePtr; $self; $tablePtr; $keyPtr; $valuePtr; $arrValuePtr; $arrKeyPtr; $sortKeyPtr)
C_POINTER:C301($1; $2)
$self:=$1
$arrValuePtr:=$2


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
