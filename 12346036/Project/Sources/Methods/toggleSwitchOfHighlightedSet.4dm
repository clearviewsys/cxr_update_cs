//%attributes = {}
// toggleswtichOfHighlighted set (->[TABLE]; ->isChecked;bool:{add/remove};->userField;->validationCodeField;validation))
// if the third parameter is left blank it toggles the state of the favorite field (or any other boolean field)
// see also: addToTableFavorite
// use this method for subforms


C_POINTER:C301($1; $2; $4; $5; $tablePtr; $fieldPtr; $userFieldPtr; $validationFieldPtr)
C_BOOLEAN:C305($3; $add; $toggle)
C_TEXT:C284($validationCode; $userField; $6)

$tablePtr:=$1
$fieldPtr:=$2
$toggle:=False:C215
GET HIGHLIGHTED RECORDS:C902($tablePtr->; "$userSet")
$userField:=""
$validationCode:=""

Case of 
	: (Count parameters:C259=2)
		$add:=True:C214
		$toggle:=True:C214  // this is true if you want toggle between on and off
		
	: (Count parameters:C259=3)
		$add:=$3
		$toggle:=False:C215
		
	: (Count parameters:C259=4)
		$add:=$3
		$toggle:=False:C215
		$userFieldPtr:=$4
		$userField:=getApplicationUser  //<>applicationUser
		
	: (Count parameters:C259=6)
		$add:=$3
		$toggle:=False:C215
		$userFieldPtr:=$4
		$userField:=getApplicationUser  //<>applicationUser
		$validationFieldPtr:=$5
		$validationCode:=$6
	Else 
		myAlert("Invalid number of parameters. Assertion error.")
End case 

C_TEXT:C284($selectionName)
$selectionName:=Table name:C256($tablePtr)
COPY NAMED SELECTION:C331($tablePtr->; $selectionName)
CREATE SET:C116($tablePtr->; "$originalSet")

If (Records in set:C195("$userSet")>0)
	USE SET:C118("$userSet")
	READ WRITE:C146($tablePtr->)
	FIRST RECORD:C50($tablePtr->)
	C_LONGINT:C283($i)
	For ($i; 1; Records in selection:C76($tablePtr->))
		LOAD RECORD:C52($tablePtr->)
		If ($toggle)
			$fieldPtr->:=Not:C34($fieldPtr->)
		Else 
			$fieldPtr->:=$add
		End if 
		$userFieldPtr->:=$userField
		
		If ($validationCode#"")
			$validationFieldPtr->:=$validationCode
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
If (Records in set:C195("$userSet")>0)
	HIGHLIGHT RECORDS:C656($tablePtr->; "$userSet")
End if 
CLEAR SET:C117("$originalSet")
CLEAR SET:C117("$userSet")