If (onNewRecordEvent)
	GOTO OBJECT:C206([LetterTemplates:53]TemplateName:1)
End if 
If (Form event code:C388=On Load:K2:1)
	C_LONGINT:C283(BodyRichText)
	4DWR_showAllMenusAndToolbars(BodyRichText)
End if 

HandleEntryForm
