//%attributes = {}
// gets MoneyGram credentials for current user

C_OBJECT:C1216($0)

Use (Storage:C1525)
	
	If (Storage:C1525.mgCredentials#Null:C1517)
		
		$0:=New object:C1471
		
		OB_CopyToSharedObject(Storage:C1525.mgCredentials; $0)
		
		
	End if 
	
End use 

