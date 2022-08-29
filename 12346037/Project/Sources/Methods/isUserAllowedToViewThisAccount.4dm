//%attributes = {}
C_BOOLEAN:C305($0; $isManager)

Case of 
	: (Count parameters:C259=0)
		$isManager:=isUserManager
	: (Count parameters:C259=1)
		$isManager:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (([Accounts:9]isRestrictedToManagers:14) & (Not:C34($isManager)))  // changed in ver. 3.427
	$0:=False:C215
Else 
	$0:=True:C214
End if 