//%attributes = {}
// addToTableFavorite (->[TABLE]; ->[table]isFavorite;boolean:{add/remove})
// if the third parameter is left blank it toggles the state of the favorite field (or any other boolean field)


C_POINTER:C301($1; $2; $tablePtr; $fieldPtr)
C_BOOLEAN:C305($3; $add; $toggle)
$tablePtr:=$1
$fieldPtr:=$2
$toggle:=False:C215
If (Count parameters:C259=3)
	$add:=$3
	$toggle:=False:C215
Else 
	$add:=True:C214
	$toggle:=True:C214  // this is true if you want toggle between on and off
End if 

C_TEXT:C284($selectionName)
C_LONGINT:C283($i)
$selectionName:=Table name:C256($tablePtr)
COPY NAMED SELECTION:C331($tablePtr->; $selectionName)
CREATE SET:C116($tablePtr->; "$originalSet")

If (Records in set:C195("UserSet")>0)
	USE SET:C118("UserSet")
	READ WRITE:C146($tablePtr->)
	FIRST RECORD:C50($tablePtr->)
	For ($i; 1; Records in selection:C76($tablePtr->))
		LOAD RECORD:C52($tablePtr->)
		If ($toggle)
			$fieldPtr->:=Not:C34($fieldPtr->)
		Else 
			$fieldPtr->:=$add
		End if 
		SAVE RECORD:C53($tablePtr->)
		NEXT RECORD:C51($tablePtr->)
	End for 
	UNLOAD RECORD:C212($tablePtr->)
	READ ONLY:C145($tablePtr->)
Else 
	myAlert("Please highlight some records first.")
End if 

USE NAMED SELECTION:C332($selectionName)
CLEAR NAMED SELECTION:C333($selectionName)
If (Records in set:C195("UserSet")>0)
	HIGHLIGHT RECORDS:C656($tablePtr->; "UserSet")
End if 
CLEAR SET:C117("$originalSet")
