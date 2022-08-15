//%attributes = {}
// isUserAllowedTo(->[users]isBooleanField)
// eg: isUserAllowedTo(->[users]isAllowedToPrintCheque)

C_POINTER:C301($1; $fieldPtr)

C_BOOLEAN:C305($0; $isAllowed)

Case of 
	: (Count parameters:C259=0)
		$fieldPtr:=->[Users:25]isAllowedToEditFees:15
	: (Count parameters:C259=1)
		$fieldPtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ([Users:25]UserID:1#<>UserID)  // this will speed up the operation when there are multiple calls (in sequence) to this method
	READ ONLY:C145([Users:25])
	QUERY:C277([Users:25]; [Users:25]UserID:1=<>UserID)  // select the current user
End if 

//If (Records in selection([Users])=1)  /// old method @tiranbe #modified on 
If (([Users:25]UserID:1=<>UserID) & (<>UserID#""))
	
	If ([Users:25]isAdministrator:33)  // admins can do anything
		$isAllowed:=True:C214
	Else 
		$isAllowed:=$fieldPtr->
	End if 
Else 
	$isAllowed:=False:C215  // if the user is not found, the default response is negative
End if 

If (isUserSuperAdmin)  // super admin has the right to do everything
	$isAllowed:=True:C214
End if 

$0:=$isAllowed