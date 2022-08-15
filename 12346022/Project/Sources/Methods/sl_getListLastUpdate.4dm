//%attributes = {}
/** Gets the list last updated

#param $shortNameParam
      the name of the list
#return 
       The updated date message
#author @wai-kin
*/
#DECLARE($shortNameParam : Text)->$response : Text

var $shortName : Text
Case of 
	: (Count parameters:C259=0)
		$shortName:="ALL"
	: (Count parameters:C259=1)
		$shortName:=$shortNameParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $status : Integer
var $url; $content : Text

$url:="https://cloud.clearviewsys.net/cxblacklist/json/getlistlastupdate?"

C_TEXT:C284($clientCode; $clientKey)
$clientCode:=replaceUnsafeURLCharacters(<>ClientCode2)
$url:=$url+"&clientcode="+$clientCode

$clientKey:=replaceUnsafeURLCharacters(<>ClientKey2)
$url:=$url+"&clientkey="+$clientKey

// fill list name
$url:=$url+"&list="+replaceUnsafeURLCharacters($shortName)

$status:=HTTP Request:C1158(HTTP POST method:K71:2; $url; $content; $response)
