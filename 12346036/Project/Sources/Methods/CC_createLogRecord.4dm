//%attributes = {}
C_TEXT:C284($1; $2; $3; $4; \
$request; $params; $status; $response)

$request:=$1
$params:=$2
$status:=$3
$response:=$4


C_OBJECT:C1216($newRecord)
$newRecord:=ds:C1482.CC_Log.new()
$newRecord.Request:=$Request
$newRecord.Params:=$params
$newRecord.Status:=$status
$newRecord.Response:=$response
$newRecord.save()

//CREATE RECORD([CC_Log])
//[CC_Log]Request:=$request
//[CC_Log]Params:=$params
//[CC_Log]Status:=$status
//[CC_Log]Response:=$response
//SAVE RECORD([CC_Log])