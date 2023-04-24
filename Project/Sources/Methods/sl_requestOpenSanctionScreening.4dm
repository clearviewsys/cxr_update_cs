//%attributes = {}
#DECLARE($name : Text; $searchList : cs:C1710.SanctionListsEntity; $offset : Integer)->$result : Object

Case of 
	: (Count parameters:C259=3)
	: (Count parameters:C259=2)
		$offset:=0
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// MARK:- Set URL
var $url; $collection : Text
$collection:=utils_getValueFromObject($searchList.Details; "default"; "OpenSanctions"; "collection")
$url:="http://sl.clearviewsys.com/search/"+$collection+"?"

var $name : Text
$name:=Replace string:C233($name; " "; "+")
$url:=$url+"q="+replaceUnsafeURLCharacters($name)

$url:=$url+"&schema="+utils_getValueFromObject($searchList.Details; "Thing"; "OpenSanctions"; "schema")

var $fuzzy : Boolean
$url:=$url+"&fuzzy="
If (utils_getValueFromObject($searchList.Details; False:C215; "OpenSanctions"; "fuzzy"))
	$url:=$url+"true"
Else 
	$url:=$url+"false"
End if 

If (Count parameters:C259=3)
	$url:=$url+"&offset="+String:C10($offset)
End if 

// MARK:- Actual Server Pull
C_LONGINT:C283($status)
$status:=0
var $content : Text
var $response : Object
$response:=New object:C1471
ON ERR CALL:C155("sl_sanctionRequestTimeout")
$status:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $content; $response)
ON ERR CALL:C155("")

$result:=New object:C1471("status"; $status; "response"; $response)

