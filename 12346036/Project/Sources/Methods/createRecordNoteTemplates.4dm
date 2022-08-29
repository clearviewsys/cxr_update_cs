//%attributes = {}

C_TEXT:C284($1; $2; $Code; $Note)

Case of 
	: (Count parameters:C259=2)
		$Code:=$1
		$Note:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([NoteTemplates:140])
// first make sure the  code doesn't exist
QUERY:C277([NoteTemplates:140]; [NoteTemplates:140]Code:3=$Code)

// if it doesn't exist then create it
If (Records in selection:C76([NoteTemplates:140])=0)
	CREATE RECORD:C68([NoteTemplates:140])
	[NoteTemplates:140]Code:3:=$Code
	[NoteTemplates:140]Notes:4:=$Note
	SAVE RECORD:C53([NoteTemplates:140])
End if 
READ ONLY:C145([NoteTemplates:140])