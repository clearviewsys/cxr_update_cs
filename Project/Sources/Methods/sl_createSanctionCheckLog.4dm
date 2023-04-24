//%attributes = {}
/* Creates a [SanctionCheckLog] Entity

#param $searchNameParam
       value for [SanctionCheckLog]FullName
#param $isEntityParam
       value for [SanctionCheckLog]isEntity
#param $methodParam
       value for [SanctionCheckLog]UseServer
#param $searchListParam
       value for [SanctionCheckLog]SearchList
#param $logId
       value for [SanctionCheckLog]InternalRecordID, and [SanctionCheckLog]internalTableID
#param $logIdParam
       an object pointer to the targe table record where
     - table = the name of the table record
     - field = the name of the table id field
     - value = the value in the field
#return 
       an object of [SanctionCheckLog]
#post  
       an [SanctionCheckLog] entity that still needs:
       **ResponseText**, **isSuccessful**, **CheckResult**, **ResponseJSON**, **Details**
#author @wai-kin
*/
#DECLARE($searchNameParam : Text; $isEntityParam : Boolean; $methodParam : Text; \
$searchListParam : Text; $logIdParam : Object)->$result : cs:C1710.SanctionCheckLogEntity
var $searchName; $method; $searchList : Text
var $isEntity : Boolean
var $logId : Object

Case of 
	: (Count parameters:C259=5)
		$searchName:=$searchNameParam
		$isEntity:=$isEntityParam
		$method:=$methodParam
		$searchList:=$searchListParam
		$logId:=$logIdParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// setup #ORDA
$result:=ds:C1482.SanctionCheckLog.new()
// _SYNC_ID 
// InternalRecordID (below)
$result.CheckDate:=Current date:C33(*)
$result.CheckTime:=Current time:C178(*)
$result.SanctionList:=$searchList
$result.Details:=New object:C1471("checkType"; $method; "data"; New object:C1471)

// ** ResponseText **
// ** isSuccessful **
$result.UserID:=getApplicationUser  //<>ApplicationUser
$result.FullName:=$searchName
// ** CheckResult **
$result.isEntity:=$isEntity
If (OB Is defined:C1231($logId; "value"))
	$result.InternalRecordID:=$logId.value
	$result.internalTableID:=$logId.table
	$result.internalFieldID:=$logId.field
End if 
$result.UseServer:=$method
$result.UUID:=Generate UUID:C1066

// UUID 
// _SYNC_DATA 
// _Sync_Hash
// ** ResponseJSON **
// ** Details **