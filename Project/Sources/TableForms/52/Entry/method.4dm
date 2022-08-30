If (onNewRecordEvent)
	[Letters:52]LetterID:1:=makeLetterID
	C_TIME:C306($time)
	setDateTimeUser(->[Letters:52]LetterDate:2; ->$time; ->[Letters:52]author:5)
	GOTO OBJECT:C206([Letters:52]Recepients:7)
	
End if 

If (Form event code:C388=On Load:K2:1)
	C_LONGINT:C283(BodyRichText)
	4DWR_showAllMenusAndToolbars(BodyRichText)
End if 

HandleEntryFormMethod