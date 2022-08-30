//%attributes = {}
// removes credentials for current 4D user from Storage by creating new empty shared object

Use (Storage:C1525)
	
	If (Storage:C1525.mgCredentials#Null:C1517)
		Use (Storage:C1525.mgCredentials)
			OB REMOVE:C1226(Storage:C1525; "mgCredentials")
		End use 
	End if 
	
End use 
