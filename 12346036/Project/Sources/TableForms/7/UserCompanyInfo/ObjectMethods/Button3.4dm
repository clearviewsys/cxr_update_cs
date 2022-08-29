
C_BOOLEAN:C305($isRegistered)
C_TEXT:C284($ret)

$ret:=RAL2_verifyClient(Form:C1466.ClientCode; Form:C1466.ClientKey)

If ($ret="0")
	myAlert(Form:C1466.ClientCode+" is registered with registration server.")
Else 
	myAlert(Form:C1466.ClientCode+" is not registered yet.")
End if 
