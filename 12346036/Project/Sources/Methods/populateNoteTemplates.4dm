//%attributes = {}

Case of 
	: (Count parameters:C259=0)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($arrCodes; 0)
ARRAY TEXT:C222($arrNotes; 0)

ALL RECORDS:C47([NoteTemplates:140])
SELECTION TO ARRAY:C260([NoteTemplates:140]Code:3; $arrCodes; [NoteTemplates:140]Notes:4; $arrNotes)
populateNoteTemplatesArrays(->$arrCodes; ->$arrNotes)

ARRAY TO SELECTION:C261($arrCodes; [NoteTemplates:140]Code:3; $arrNotes; [NoteTemplates:140]Notes:4)
UNLOAD RECORD:C212([NoteTemplates:140])
READ ONLY:C145([NoteTemplates:140])

