If (Form event code:C388=On Selection Change:K2:29)
	C_LONGINT:C283($match)
	Form:C1466.match:=0
	If (Form:C1466.selected#Null:C1517)
		handleCustomerMatchStamp
	Else 
		stampText("stamp"; "")
	End if 
End if 