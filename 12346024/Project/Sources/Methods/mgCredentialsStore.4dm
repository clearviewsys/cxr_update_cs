//%attributes = {}
// stores MoneyGram credentials for current session

C_OBJECT:C1216($1; $credentials)

$credentials:=$1

Use (Storage:C1525)
	
	If (Storage:C1525.mgCredentials=Null:C1517)
		Storage:C1525.mgCredentials:=New shared object:C1526
	End if 
	
	Use (Storage:C1525.mgCredentials)
		
		OB_CopyToSharedObject($credentials; Storage:C1525.mgCredentials)
		
	End use 
	
End use 


