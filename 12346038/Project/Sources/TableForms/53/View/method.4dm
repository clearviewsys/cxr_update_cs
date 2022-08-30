handleViewForm

If (Form event code:C388=On Load:K2:1)
	GOTO OBJECT:C206([LetterTemplates:53]TemplateName:1)
	C_LONGINT:C283(BodyRichText)
	4dwr_hideAllMenusAndToolbars(BodyRichText)
	
End if 


