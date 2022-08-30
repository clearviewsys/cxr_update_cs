//%attributes = {}
// handleUniqueFieldObjectMethod ( ->[customers]email; ->[customers]customerID; "Duplicate Email")
// see also: isFieldValueUnique

C_POINTER:C301($1; $2)
C_TEXT:C284($alert; $3)

C_POINTER:C301($fieldPtr; $keyPtr)
C_OBJECT:C1216($o)
C_TEXT:C284($query; $fieldName; $keyName)

Case of 
	: (Count parameters:C259=2)
		$fieldPtr:=$1  // e.g. ->[Customers]Email
		$keyPtr:=$2  // e.g. ->[customers]CustomerID
		$alert:="This is a duplicate entry!"
		
	: (Count parameters:C259=3)
		$fieldPtr:=$1  // e.g. ->[Customers]Email
		$keyPtr:=$2  // e.g. ->[customers]CustomerID
		$alert:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Form event code:C388=On Data Change:K2:15)
	// make sure the email is correct and also unique
	
	
	$fieldName:=Field name:C257($fieldPtr)
	$keyName:=Field name:C257($keyPtr)
	
	If (String:C10($fieldPtr->)#"")  // we don't want to search for empty strings (e.g. when picture ID is missing)
		
		$query:=$fieldName+" === :1 and "+$keyName+"!== :2"  // the === and !== are used to make sure  @ is not a wildcard
		$o:=ds:C1482.Customers.query($query; $fieldPtr->; $keyPtr->)
		
		If ($o.length>0)
			myAlert($alert)
			displayCustomersMatchingName($o; $alert)
			//$fieldPtr->:=""
		End if 
		
	End if 
	
End if 