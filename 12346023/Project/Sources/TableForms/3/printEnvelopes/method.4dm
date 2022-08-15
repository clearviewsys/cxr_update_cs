C_LONGINT:C283(env_cbPrintLogo; env_cbPrintSender)

If (Form event code:C388=On Load:K2:1)
	env_cbPrintLogo:=0
	env_cbPrintSender:=0
	FIRST RECORD:C50([Customers:3])
End if 

env_handlePrintedObjects


