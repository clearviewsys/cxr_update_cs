//%attributes = {}
If (Form event code:C388=On After Edit:K2:43)
	SET TIMER:C645(10)
End if 

If (Form event code:C388=On Data Change:K2:15)
	GOTO OBJECT:C206(*; "ListBox")
End if 
