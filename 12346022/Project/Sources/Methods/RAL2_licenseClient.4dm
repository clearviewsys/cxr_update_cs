//%attributes = {}
//Method for checking and creating a client license
//Parameters: Client Code (string), Application ID (string)
//*******************************************************


//Parameters
C_TEXT:C284($0; $1; $2; $clientCode; $applicationId)
//Internal
C_TEXT:C284($params; $body; $response; $requestUrl)
C_POINTER:C301($pHeaderNames; $pHeaderValues; $pParams)
C_LONGINT:C283($status)
C_OBJECT:C1216($oParams)  //;$oResponse)
C_COLLECTION:C1488($oResponse)
ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)
$oParams:=New object:C1471()

Case of 
	: (Count parameters:C259=2)
		$clientCode:=$1
		$applicationId:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$oParams.ralKey:=RAL2_getRALKey
$oParams.clientCode:=$clientCode
$oParams.applicationId:=$applicationId

$pHeaderNames:=->$headerNames
$pHeaderValues:=->$headerValues
$pParams:=->$params
HTTPSetRequest($pHeaderNames; $pHeaderValues; $pParams; $oParams)

$requestUrl:="https://cloud.clearviewsys.net/ral/json/licenseClient?"+$params

ON ERR CALL:C155("RAL2_errMethod")
$status:=HTTP Request:C1158(HTTP GET method:K71:1; $requestUrl; $body; $response)

$oResponse:=JSON Parse:C1218($response)
ON ERR CALL:C155("")

//Possible responses are:
//0: SUCCESS, valid license
//1: Server error
//2: Input error
//3: Service not available
//11: Registration not activated
//18: Client not found
//21: Application not found
//20: SUCCESS, valid trial license created
//22: Application License expired
//23: Monthly limit reached
//24: Total Limit reached
//29: Master License expired

If ($status=200)
	$0:=$oResponse[0]
Else 
	$0:="1"
End if 



