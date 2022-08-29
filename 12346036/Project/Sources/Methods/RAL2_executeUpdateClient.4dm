//%attributes = {}
//Method for Updating a client wih the RAL webserver
//Parameters: ClientCode(string), ClientKey(string), newClientKey (string), FirstName(string), LastName(string), isCompany(bool),
//            CompanyName(string), email(string), phone(string), city(string), province(string),
//            country(string), postalCode(string)
//Called from RAL2_UpdateClient, which allows various parameters

//Parameters
C_OBJECT:C1216($0)
C_TEXT:C284($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13)
C_TEXT:C284($clientCode; $clientKey; $newClientKey; $firstName; $isCompany; $lastName; $companyName; $email; $phone; $address; $city; $province; $country; $postalCode)
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
	: (Count parameters:C259=13)
		$clientCode:=$1
		$clientKey:=$2
		$newClientKey:=$3
		$firstName:=$4
		$lastName:=$5
		$isCompany:=$6
		$companyName:=$7
		$phone:=$8
		$address:=$9
		$city:=$10
		$province:=$11
		$country:=$12
		$postalCode:=$13
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$oParams.ralKey:=RAL2_getRALKey
$oParams.clientCode:=$clientCode
$oParams.clientKey:=$clientKey
$oParams.newClientKey:=$newClientKey
$oParams.newFirstName:=$firstName
$oParams.newLastName:=$lastName
$oParams.newIsCompany:=$isCompany
$oParams.newCompanyName:=$companyName
$oParams.newPhone:=$phone
$oParams.newAddress:=$address
$oParams.newCity:=$city
$oParams.newProvince:=$province
$oParams.newCountry:=$country
$oParams.newPostalCode:=$postalCode

//removeBlankFields ($oParams)

$pHeaderNames:=->$headerNames
$pHeaderValues:=->$headerValues
$pParams:=->$params
HTTPSetRequest($pHeaderNames; $pHeaderValues; $pParams; $oParams)

$requestUrl:="https://cloud.clearviewsys.net/ral/json/updateClient?"+$params

ON ERR CALL:C155("RAL2_errMethod")
$status:=HTTP Request:C1158(HTTP GET method:K71:1; $requestUrl; $body; $response)

$oResponse:=JSON Parse:C1218($response)
ON ERR CALL:C155("")


$0:=New object:C1471("response"; $oResponse[0])
