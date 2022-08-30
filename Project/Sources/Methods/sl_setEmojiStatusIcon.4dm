//%attributes = {}
/** gets the emoji for sanction screening result

#param $statusCodeParam
       the status code
#retun status as an emoji
#author @wai-kin
*/
#DECLARE($statusCodeParam : Integer)->$result : Text

var $statusCode : Integer
Case of 
	: (Count parameters:C259=1)
		$statusCode:=$statusCodeParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: ($statusCode=-1)
		$result:="⚠"
	: ($statusCode=0)
		$result:="✔"
	: ($statusCode=1)
		$result:="❗"
	: ($statusCode=2)
		$result:="❌"
End case 