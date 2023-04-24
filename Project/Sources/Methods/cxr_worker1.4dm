//%attributes = {}
// cxr_worker1
#DECLARE($customerNoCollection : Collection)->$numRecs : Integer
ARRAY TEXT:C222($arrCustomerNo; 0)
C_LONGINT:C283($i)


C_OBJECT:C1216($API_Params; $customer)

$API_Params:=New object:C1471
$customer:=New object:C1471


$API_Params.source:="CVSFILE"
$API_Params.userid:="jaimecvs"
$API_Params.entity:="CVS"
$API_Params.branch:="010"

$API_Params.customerNo:="071651537"

cxr_QueryCustomer_Search($API_Params)



//COLLECTION TO ARRAY($customerNoCollection; $arrCustomerNo)

// TODO: Test this code
//For ($i; 1; Size of array($arrCustomerNo))
//$API_Params.customerNo:=$arrCustomerNo{$i}
//CALL WORKER("myWorker1"; "cxr_QueryCustomer_Search"; $API_Params)
//End for 





