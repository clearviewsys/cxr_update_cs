//%attributes = {}
var $address : Text

$address:="123 Vancouver av."

FJ_AddTagToReport(":P14:"; $address; True:C214)

automaticUpdates

If (False:C215)
	C_TEXT:C284($sqlQuery)
	ARRAY TEXT:C222(arrCodes; 0)
	ARRAY TEXT:C222(arrDesc; 0)
	
	$sqlQuery:="SELECT TRN_CODE, TRN_DESC FROM sttm_trn_code"
	$sqlQuery:="SELECT MODULE_ID, MODULE_DESC FROM smtb_modules"
	//CAB_SingleQuery($sqlQuery)
	
	$sqlQuery:=createQueryCustomerIOReq
	
	
	$sqlQuery:="SELECT TRN_CODE, TRN_DESC FROM sttm_trn_code"
	$sqlQuery:="SELECT TRN_CODE, TRN_DESC FROM sttm_trn_code"
	$sqlQuery:=createQueryCustomerIOReq
End if 
