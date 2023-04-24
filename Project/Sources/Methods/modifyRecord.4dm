//%attributes = {"publishedWeb":true}
// modifyRECORDS (-> [TABLE] {{{ ;  modifyForm } )
// defaults: modifyForm = "MODIFY"
// OUTPUT FORM is always set to "List"

C_POINTER:C301($1; $tablePtr)
C_LONGINT:C283(bSearch; $totalRecords)
C_TEXT:C284($2; $3; $modifyForm; $listForm; $namedSelection)
C_TEXT:C284($4; $setName)  // Modified by: Barclay Berry (7/26/13)-- changed to $4 from $5


// set the default form
$listForm:="List"

Case of 
	: (Count parameters:C259=1)
		$tablePtr:=$1
		$modifyForm:="Entry"
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$modifyForm:=$2
		
	: (Count parameters:C259=3)  // added by @milan 12/12/22
		$tablePtr:=$1
		$modifyForm:=$2
		$listForm:=$3
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (isUserAuthorizedToModify($tablePtr))
	
	// query by example opens the input form
	//bSearch:=0
	
	// Modified by: Tiran Behrouz (3/21/13)
	//$recordNumber:=<>RecordNo
	//setErrorTrap ("modifyRecord";"An Error occured while executing a modify record")
	
	$namedSelection:=getTableNamedSelection($tablePtr)
	
	CREATE SET:C116($tablePtr->; "$originalSelection")
	COPY NAMED SELECTION:C331($tablePtr->; $namedSelection)
	
	If (Records in set:C195("userSet")=0)  // @milan fix when set doesn't exists
		CREATE EMPTY SET:C140($tablePtr->; "userSet")
	Else 
		USE SET:C118("userSet")
	End if 
	
	COPY SET:C600("userSet"; $namedSelection)
	
	If (Records in selection:C76($tablePtr->)>0)
		FORM SET OUTPUT:C54($tablePtr->; $listForm)
		modifyRecordTable($tablePtr; $modifyForm)
	End if 
	
	USE SET:C118("$originalSelection")
	USE NAMED SELECTION:C332($namedSelection)
	CLEAR NAMED SELECTION:C333($namedSelection)
	HIGHLIGHT RECORDS:C656($namedSelection)
	CLEAR SET:C117($namedSelection)
	endErrorTrap
	
Else 
	myAlert("You are not authorized to modify records from "+getElegantTableName($tablePtr))
End if 
