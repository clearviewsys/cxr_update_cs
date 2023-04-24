//%attributes = {}
// fixDuplicateRecords (->[table];->field)
// mark  duplicate records and make a field by field comparison using the last time stamp date to generate an updated record

C_LONGINT:C283($progress)
C_LONGINT:C283($i; $j; $p; $n; $k; $q; $latestRecord; $numRecords)
C_POINTER:C301($tablePtr; $fieldPtr; $1; $2)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=->[Customers:3]
		$fieldPtr:=->[Customers:3]CustomerID:1
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$fieldPtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_TEXT:C284($t1)
ARRAY TEXT:C222($arr; 0)
ARRAY TEXT:C222($arrTS; 0)
ARRAY TEXT:C222($arrTSName; 0)

ORDER BY:C49($tablePtr->; $fieldPtr->)
FIRST RECORD:C50($tablePtr->)

$i:=1
$numRecords:=0

$n:=Records in selection:C76($tablePtr->)

$progress:=launchProgressBar("Fixing duplicate records...")

C_TEXT:C284($idMaster; $uuidMaster; $currentCustID)
ARRAY TEXT:C222($arrCustomers; 0)

// APPEND TO ARRAY($arrCustomers;"DCCUS1000036")
// APPEND TO ARRAY($arrCustomers;"DCCUS1009311")
// QUERY WITH ARRAY([Customers]CustomerID;$arrCustomers)
// REDUCE SELECTION([Customers];1)

ORDER BY:C49([Customers:3]; [Customers:3]ModificationDate:56; <)

// loop across all duplicate customers
FIRST RECORD:C50([Customers:3])

C_TEXT:C284($msg; $syncIDMaster)
$msg:=""
READ WRITE:C146($tablePtr->)
ARRAY TEXT:C222($arrCustomers; 0)
ARRAY TEXT:C222($arrSyncID; 0)

ARRAY TEXT:C222($arrCustomersDupl; 0)
ARRAY TEXT:C222($arrSyncIDDupl; 0)

SELECTION TO ARRAY:C260([Customers:3]CustomerID:1; $arrCustomers; [Customers:3]_Sync_ID:94; $arrSyncID)

For ($k; 1; Size of array:C274($arrCustomers))
	
	ARRAY TEXT:C222($arrFieldNameMain; 0)
	ARRAY TEXT:C222($arrTimeStampsMain; 0)
	ARRAY TEXT:C222($arrFieldValMain; 0)
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "mainSet")
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$arrCustomers{$k})
	ORDER BY:C49([Customers:3]; [Customers:3]ModificationDate:56; <)  // descending order
	FIRST RECORD:C50([Customers:3])  // Just to be sure!
	REDUCE SELECTION:C351([Customers:3]; 1)
	
	USE SET:C118("mainSet")
	
	$idMaster:=[Customers:3]CustomerID:1
	$syncIDMaster:=[Customers:3]_Sync_ID:94
	
	getTimeStamps($tablePtr; ->$arrFieldNameMain; ->$arrTimeStampsMain; ->$arrFieldValMain)
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "duplSet")
	
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$idMaster; *)
	QUERY:C277([Customers:3];  & ; [Customers:3]_Sync_ID:94#$syncIDMaster)
	
	USE SET:C118("duplSet")
	
	ARRAY TEXT:C222($arrCustomersDupl; 0)
	ARRAY TEXT:C222($arrSyncIDDupl; 0)
	
	SELECTION TO ARRAY:C260([Customers:3]CustomerID:1; $arrCustomersDupl; [Customers:3]_Sync_ID:94; $arrSyncIDDupl)
	
	For ($q; 1; Size of array:C274($arrCustomersDupl))
		
		SET QUERY DESTINATION:C396(Into set:K19:2; "duplSet")
		QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$idMaster; *)
		QUERY:C277([Customers:3];  & ; [Customers:3]_Sync_ID:94=$arrSyncIDDupl{$q})
		
		
		ARRAY TEXT:C222($arrFieldNameDup; 0)
		ARRAY TEXT:C222($arrTimeStampsDup; 0)
		ARRAY TEXT:C222($arrFieldValDup; 0)
		ARRAY TEXT:C222($arrFields2Update; 0)
		
		USE SET:C118("duplSet")
		START TRANSACTION:C239
		
		getTimeStamps($tablePtr; ->$arrFieldNameDup; ->$arrTimeStampsDup; ->$arrFieldValDup)
		getRecordChanges($tablePtr; ->$arrFieldNameMain; ->$arrTimeStampsMain; ->$arrFieldValMain; ->$arrFieldNameDup; ->$arrTimeStampsDup; ->$arrFieldValDup; ->$arrFields2Update)
		createUpdatedRecord($tablePtr; $syncIDMaster; [Customers:3]_Sync_ID:94; ->$arrFields2Update; [Customers:3]CustomerID:1)
		
		$numRecords:=$numRecords+1
		VALIDATE TRANSACTION:C240
		
	End for 
	
	
End for 


HIDE PROCESS:C324($progress)
CLEAR SET:C117("duplSet")
SET QUERY DESTINATION:C396(Into current selection:K19:1)
QUERY WITH ARRAY:C644([Customers:3]CustomerID:1; $arrCustomers)
myAlert("fixDuplicateRecords: "+String:C10($numRecords)+" records Updated/Flagged for deletion. \nProcess finished")


