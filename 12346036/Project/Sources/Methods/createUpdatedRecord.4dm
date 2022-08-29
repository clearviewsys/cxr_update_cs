//%attributes = {}

// createUpdatedRecord($arrFieldNameMainPtr;$arrTimeStampsMainPtr;$arrFieldNameDupPtr;$arrTimeStampsDupPtr)

C_POINTER:C301($1; $tablePtr; $4; $arrFields2UpdatePtr)
C_TEXT:C284($2; $syncIdDMain; $3; $syncIdDSupl; $5; $customerID)


Case of 
		
	: (Count parameters:C259=5)
		
		$tablePtr:=$1
		$syncIdDMain:=$2
		$syncIdDSupl:=$3
		$arrFields2UpdatePtr:=$4
		$customerID:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($i)
C_TEXT:C284($fieldName; $syncIdMain; $syncIdDup; $fieldNameSyncID)
C_POINTER:C301($ptrMain; $ptrDupl; $syncIdDuplPtr; $syncIdMainPtr)

C_LONGINT:C283($type)
C_TEXT:C284($txtValue)

C_BOOLEAN:C305($updateName)
C_OBJECT:C1216($entity; $entityCloned; $sel)

If (Position:C15([Customers:3]LastName:4; "??_")=0)
	[Customers:3]LastName:4:="??_"+[Customers:3]LastName:4
	[Customers:3]FirstName:3:="??_"+[Customers:3]FirstName:3
Else 
	[Customers:3]LastName:4:=Replace string:C233([Customers:3]LastName:4; "??_"; "")
	[Customers:3]FirstName:3:=Replace string:C233([Customers:3]FirstName:3; "??_"; "")
End if 
[Customers:3]CustomerID:1:="x"+[Customers:3]CustomerID:1  // ibb
SAVE RECORD:C53($tablePtr->)  // Save Duplicate record puting ?? on FirstName/LastName

UTIL_Log("Duplicates"; "Record Flagged for deletion: (Sync ID):"+[Customers:3]_Sync_ID:94)
UTIL_Log("Duplicates"; "------------------------------------------------")

For ($i; 1; Size of array:C274($arrFields2UpdatePtr->))
	
	$fieldName:=$arrFields2UpdatePtr->{$i}
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "duplSet")
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1="x"+$customerID; *)
	QUERY:C277([Customers:3];  & ; [Customers:3]_Sync_ID:94=$syncIdDSupl)
	USE SET:C118("duplSet")
	
	$syncIdDuplPtr:=getFieldPointer($tablePtr; $fieldName)
	$ptrDupl:=getFieldPointer($tablePtr; $fieldName)
	
	CLEAR VARIABLE:C89($sel)
	OB SET:C1220($sel; "value"; $ptrDupl->)
	C_LONGINT:C283($type)
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "mainSet")
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$customerID; *)
	QUERY:C277([Customers:3];  & ; [Customers:3]_Sync_ID:94=$syncIdDMain)
	USE SET:C118("mainSet")
	
	$syncIdMainPtr:=getFieldPointer($tablePtr; $fieldName)
	$ptrMain:=getFieldPointer($tablePtr; $fieldName)
	
	$type:=OB Get type:C1230($sel; "value")
	Case of 
		: ($type=Is picture:K8:10)
			$ptrMain->:=OB Get:C1224($sel; "value")
		: ($type=Is text:K8:3) | ($type=Is alpha field:K8:1)
			If ($sel.value="")
			Else 
				$ptrMain->:=$sel.value
			End if 
		: ($type=Is date:K8:7)
			If ($sel.value=!00-00-00!)
			Else 
				$ptrMain->:=$sel.value
			End if 
			
		: ($type=Is time:K8:8)
			If ($sel.value=?00:00:00?)
			Else 
				$ptrMain->:=$sel.value
			End if 
			
		: ($type=Is longint:K8:6) | ($type=Is real:K8:4) | ($type=Is integer:K8:5)
			If ($sel.value=0)
			Else 
				$ptrMain->:=$sel.value
			End if 
			
		Else 
			$ptrMain->:=$sel.value
	End case 
	
	
End for 

SAVE RECORD:C53($tablePtr->)  // Save info in master record


