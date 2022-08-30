//%attributes = {}
//Method for registering a client wih the RAL webserver
//Parameters: ClientKey(string), FirstName(string), LastName(string), isCompany(bool),
//            CompanyName(string), email(string), phone(string), city(string), province(string),
//            country(string), postalCode(string)

//Parameters
C_OBJECT:C1216($0)
C_TEXT:C284($1; $2; $3; $5; $6; $7; $8; $9; $10; $11; $12)
C_TEXT:C284($clientKey; $firstName; $lastName; $companyName; $email; $phone; $address; $city; $province; $country; $postalCode)
C_BOOLEAN:C305($4; $isCompany)
//Internal
C_TEXT:C284($params; $body; $response; $requestUrl)
C_POINTER:C301($pHeaderNames; $pHeaderValues; $pParams)
C_LONGINT:C283($status)
C_OBJECT:C1216($oParams)
C_COLLECTION:C1488($oResponse)
ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)
$oParams:=New object:C1471()

Case of 
	: (Count parameters:C259=12)
		$clientKey:=$1
		$firstName:=$2
		$lastName:=$3
		$isCompany:=$4
		$companyName:=$5
		$email:=$6
		$phone:=$7
		$address:=$8
		$city:=$9
		$province:=$10
		$country:=$11
		$postalCode:=$12
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$oParams.ralKey:=RAL2_getRALKey
$oParams.clientKey:=$clientKey
$oParams.firstName:=$firstName
$oParams.lastName:=$lastName
$oParams.isCompany:=String:C10($isCompany)
$oParams.companyName:=$companyName
$oParams.email:=$email
$oParams.phone:=$phone
$oParams.address:=$address
$oParams.city:=$city
$oParams.province:=$province
$oParams.country:=$country
$oParams.postalCode:=$postalCode

$pHeaderNames:=->$headerNames
$pHeaderValues:=->$headerValues
$pParams:=->$params
HTTPSetRequest($pHeaderNames; $pHeaderValues; $pParams; $oParams)

$requestUrl:="https://cloud.clearviewsys.net/ral/json/registerClient?"+$params

ON ERR CALL:C155("RAL2_errMethod")
$status:=HTTP Request:C1158(HTTP GET method:K71:1; $requestUrl; $body; $response)

$oResponse:=JSON Parse:C1218($response)
ON ERR CALL:C155("")

If ($oResponse[0]="0")
	$0:=New object:C1471("response"; $oResponse[0]; "clientCode"; $oResponse[1]; "clientKey"; $oResponse[2])
Else 
	$0:=New object:C1471("response"; $oResponse[0])
End if 
