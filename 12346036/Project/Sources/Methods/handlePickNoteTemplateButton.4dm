//%attributes = {}
// handlePickNoteTemplateButton (-> NoteField)
// use this method in a button script to bring up the noteTemplate picker and simplify entering notes


C_POINTER:C301($fieldPtr; $1)

Case of 
	: (Count parameters:C259=0)
		$fieldPtr:=->[CallLogs:51]Notes:6  // 
	: (Count parameters:C259=1)
		$fieldPtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($var)
pickNoteTemplates(->$var; True:C214)  // $var become the value of the NoteTemplate picked by the user
If (OK=1)
	If ($fieldPtr->="")
		$fieldPtr->:=$var
	Else 
		$fieldPtr->:=$fieldPtr->+CRLF+$var
	End if 
End if 