//%attributes = {}
/** Get the List name from server, might be null. This is from
https://cloud.clearviewsys.net/cxblacklist/json/getlistnames
#return the result from the server
#Author @Wai-Kin
*/
#DECLARE->$response : Collection

var $status : Integer
var $url; $content : Text
$response:=New collection:C1472

$url:="https://cloud.clearviewsys.net/cxblacklist/json/getListNames?"

C_TEXT:C284($clientCode; $clientKey)
$clientCode:=replaceUnsafeURLCharacters(<>ClientCode2)
$url:=$url+"&clientcode="+$clientCode

$clientKey:=replaceUnsafeURLCharacters(<>ClientKey2)
$url:=$url+"&clientkey="+$clientKey

C_LONGINT:C283($status)
$status:=0
$response:=New collection:C1472
ON ERR CALL:C155("sl_sanctionRequestTimeout")
$status:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $content; $response)
ON ERR CALL:C155("")