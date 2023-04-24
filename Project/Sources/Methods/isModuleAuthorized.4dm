//%attributes = {}
//isModuleAuthorized (->[table])

C_BOOLEAN:C305($isAuthorized; $0)
C_POINTER:C301($tablePtr; $1)

If (Current user:C182="Designer")
	$isAuthorized:=True:C214
Else 
	$tablePtr:=$1
	
	
	QUERY:C277([TableLimitations:55]; [TableLimitations:55]TableNo:1=Table:C252($tablePtr))  // first look for the exception
	
	If (Records in selection:C76([TableLimitations:55])=1)  // if exception is found then it depends on the setting
		LOAD RECORD:C52([TableLimitations:55])
		$isAuthorized:=[TableLimitations:55]isActivated:4
		// now check for the date
		If (isDateExpired([TableLimitations:55]ExpiryDate:3))
			$isAuthorized:=False:C215
		End if 
	Else 
		// if not found then look at the default
		QUERY:C277([TableLimitations:55]; [TableLimitations:55]TableNo:1=0)
		If (Records in selection:C76([TableLimitations:55])=1)
			LOAD RECORD:C52([TableLimitations:55])
			$isAuthorized:=[TableLimitations:55]isActivated:4
			If (isDateExpired([TableLimitations:55]ExpiryDate:3))
				$isAuthorized:=False:C215
			End if 
		Else 
			$isAuthorized:=False:C215
		End if 
		
	End if 
End if 


$0:=$isAuthorized