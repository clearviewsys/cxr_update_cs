If (Form event code:C388=On Clicked:K2:4)
	If (Form:C1466.autoCheck)
		OBJECT SET TITLE:C194(*; "check_auto"; "Run automaticlly in")
	Else 
		OBJECT SET TITLE:C194(*; "check_auto"; "Run manually")
	End if 
End if 