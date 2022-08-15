//%attributes = {}
// isTableAuthorized(->[table])->boolean
// returns true if the module is authorized for 1 more ADD RECORD

C_POINTER:C301($1; $tablePtr; $fieldPtr)
C_BOOLEAN:C305($0; $isAuthorized)

//selectMAC 
//$fieldPtr:=getModuleFieldPtr ($1)
//If ($fieldPtr-><0)  `if the number is negative, then the module is authorized
//$0:=True
//Else 
//If (Records in table($1->)>=$fieldPtr->)
//$0:=False
//Else 
//$0:=True
//End if 
//
//End if 

$tablePtr:=$1

QUERY:C277([TableLimitations:55]; [TableLimitations:55]TableNo:1=Table:C252($tablePtr))  // first look for the exception

If (Records in selection:C76([TableLimitations:55])=1)  // if exception is found then it depends on the setting
	LOAD RECORD:C52([TableLimitations:55])
	If (([TableLimitations:55]MaxRecords:2>=0) & ([TableLimitations:55]MaxRecords:2<=Records in table:C83($tablePtr->)))
		$isAuthorized:=False:C215
	Else 
		$isAuthorized:=True:C214
	End if 
Else 
	// if not found then look at the default
	QUERY:C277([TableLimitations:55]; [TableLimitations:55]TableNo:1=0)
	If (Records in selection:C76([TableLimitations:55])=0)  // not found the default privilege
		$isAuthorized:=False:C215
	Else 
		LOAD RECORD:C52([TableLimitations:55])
		If (([TableLimitations:55]MaxRecords:2>=0) & ([TableLimitations:55]MaxRecords:2<=Records in table:C83($tablePtr->)))
			$isAuthorized:=False:C215
		Else 
			$isAuthorized:=True:C214
		End if 
	End if 
End if 

$0:=$isAuthorized