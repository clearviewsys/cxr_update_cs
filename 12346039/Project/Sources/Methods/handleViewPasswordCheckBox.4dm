//%attributes = {}
//handleViewPasswordCheckBox(checkBoxName;->passwordField)
// getBuild

C_LONGINT:C283($1; $checkBox)
C_POINTER:C301($2; $fieldPtr)

$checkBox:=$1
$fieldPtr:=$2

If ($checkBox=0)
	setFieldAsPassword($fieldPtr)
Else 
	OBJECT SET FONT:C164($fieldPtr->; "Arial")
End if 
