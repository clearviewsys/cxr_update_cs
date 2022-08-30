If (Form event code:C388=On Clicked:K2:4)
	If (Form:C1466.selectedList["List URL"]#"")
		OPEN URL:C673(Form:C1466.selectedList["List URL"])
	End if 
End if 