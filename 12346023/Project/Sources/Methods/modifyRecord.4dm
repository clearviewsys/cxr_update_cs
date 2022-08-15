//%attributes = {"publishedWeb":true}
// modifyRECORDS (-> [TABLE] {{{ ;  modifyForm } )
// defaults: modifyForm = "MODIFY"
// OUTPUT FORM is always set to "List"

C_POINTER:C301($1; $tablePtr)
C_LONGINT:C283(bSearch; $totalRecords)
C_TEXT:C284($2; $3; $modifyForm; $listForm)
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
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (isUserAuthorizedToModify($tablePtr))
	
	// query by example opens the input form
	//bSearch:=0
	
	// Modified by: Tiran Behrouz (3/21/13)
	//$recordNumber:=<>RecordNo
	//setErrorTrap ("modifyRecord";"An Error occured while executing a modify record")
	
	CREATE SET:C116($1->; "$originalSelection")
	COPY NAMED SELECTION:C331($tablePtr->; getTableNamedSelection($tablePtr))
	
	USE SET:C118("userSet")
	COPY SET:C600("userSet"; getTableNamedSelection($tablePtr))
	
	If (Records in selection:C76($1->)>0)
		FORM SET OUTPUT:C54($1->; $listForm)
		modifyRecordTable($1; $modifyForm)
	End if 
	
	USE SET:C118("$originalSelection")
	USE NAMED SELECTION:C332(getTableNamedSelection($tablePtr))
	CLEAR NAMED SELECTION:C333(getTableNamedSelection($tablePtr))
	HIGHLIGHT RECORDS:C656(getTableNamedSelection($tablePtr))
	CLEAR SET:C117(getTableNamedSelection($tablePtr))
	endErrorTrap
	
Else 
	myAlert("You are not authorized to modify records from "+getElegantTableName($tablePtr))
End if 


