//%attributes = {}
// handlePickNoteTemplatesMenu (-> field) 
// this generic code shall be called from a dropdown menu
// e.g. 
// use this method in a drop down menu script is to simplify entering notes by picking note codes

C_POINTER:C301($fieldPtr; $1)
C_POINTER:C301($arrayPtr; $2)


Case of 
	: (Count parameters:C259=0)
		$fieldPtr:=->[CallLogs:51]Notes:6  // 
		$arrayPtr:=Self:C308
	: (Count parameters:C259=1)
		$fieldPtr:=$1
		$arrayPtr:=Self:C308
	: (Count parameters:C259=2)
		$fieldPtr:=$1
		$arrayPtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222($arrayPtr->; 0)
	READ ONLY:C145([NoteTemplates:140])
	ALL RECORDS:C47([NoteTemplates:140])
	SELECTION TO ARRAY:C260([NoteTemplates:140]Code:3; $arrayPtr->)
End if 

If (Form event code:C388=On Clicked:K2:4)
	
	C_LONGINT:C283($index)
	C_TEXT:C284($notes)
	
	QUERY:C277([NoteTemplates:140]; [NoteTemplates:140]Code:3=$arrayPtr->{$arrayPtr->})  // assume we will find a 
	$notes:=[NoteTemplates:140]Notes:4
	
	If ($fieldPtr->="")
		$fieldPtr->:=$notes
	Else 
		$fieldPtr->:=$fieldPtr->+CRLF+$notes
	End if 
	
End if 
