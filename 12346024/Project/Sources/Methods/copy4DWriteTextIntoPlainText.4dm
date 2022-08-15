//%attributes = {}
// copy4DWriteTextIntoPlainText (4dWriteArea;->destinationField)
C_LONGINT:C283($4dwriteArea; $1)
C_POINTER:C301($fieldPtr; $2)

$4dwriteArea:=$1
$fieldPtr:=$2

If (is4DWriteAvailable)
	If ($fieldPtr->="")
		//$fieldPtr->:=‘12000;20‘ ($4dWriteArea;0;32000)
	Else 
		CONFIRM:C162("This will replace the content of the destination field!. Are you sure you want to"+" continue?"; "Replace"; "Don't Replace")
		If (OK=1)
			//$fieldPtr->:=‘12000;20‘ ($4dWriteArea;0;32000)
		End if 
	End if 
End if 