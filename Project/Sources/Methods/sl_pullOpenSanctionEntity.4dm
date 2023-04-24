//%attributes = {}
#DECLARE($idParam : Text)->$response : Object

var $id : Text
Case of 
	: (Count parameters:C259=1)
		$id:=$idParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


var $base : Text
$base:="http://sl.clearviewsys.com"
var $url : Text
$url:=$base+"/entities/"+$id

// MARK:- Actual Server Pull
C_LONGINT:C283($status)
$status:=0
var $content : Text
ARRAY TEXT:C222($headersNames; 0)
ARRAY TEXT:C222($headersValues; 0)
$response:=New object:C1471
ON ERR CALL:C155("sl_sanctionRequestTimeout")
$status:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $content; $response; $headersNames; $headersValues)
ON ERR CALL:C155("")


If ($status=308)
	var $idx : Integer
	$idx:=1
	For ($idx; 1; Size of array:C274($headersNames))
		If ($headersNames{$idx}="location")
			$status:=HTTP Request:C1158(HTTP GET method:K71:1; $base+$headersValues{$idx}; $content; $response)
			$response.referId:=$id
			break
		End if 
	End for 
End if 

$response.status:=$status