//%attributes = {}
// Author: Wai-Kin
//sl_k20requestSanctionDetails($searchID : Text)->$result : Object)

var $searchID; $1 : Text
var $result; $0 : Object
$searchID:=""
Case of 
	: (Count parameters:C259=0)
		
	: (Count parameters:C259=1)
		$searchID:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($url)
$url:="https://api.kyc2020.com:8088/KYC2020/RecordDetails"


C_OBJECT:C1216($content)
$content:=New object:C1471

$content.Email:=getLicenseValue("KYC2020")
$content.APIKey:=getLicensePassword("KYC2020")

OB SET:C1220($content; "SearchReferenceID"; $1)

C_OBJECT:C1216($response)
$response:=New object:C1471
C_LONGINT:C283($statusCode)
$statusCode:=HTTP Request:C1158(HTTP POST method:K71:2; $url; $content; $response)

$result:=New object:C1471
OB SET:C1220($result; "response"; $response; "status"; $statusCode)
$0:=$result