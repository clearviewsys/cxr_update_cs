//%attributes = {}
// K20_recieveRecordDetails($searchID)
// Author: Wai-Kin Chau
C_TEXT:C284($searchID; $1)
C_OBJECT:C1216($0)
Case of 
	: (Count parameters:C259=0)
		$searchID:=""
	: (Count parameters:C259=1)
		$searchID:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($url)
$url:="https://api.kyc2020.com:8088/KYC2020/RecordDetails"

C_OBJECT:C1216($content)
$content:=New object:C1471

OB SET:C1220($content; "APIKey"; getKeyValue("KYC2020.APIkey"))
OB SET:C1220($content; "Email"; getKeyValue("KYC2020.Email"))

OB SET:C1220($content; "SearchReferenceID"; $1)

C_OBJECT:C1216($response)
$response:=New object:C1471
C_LONGINT:C283($statusCode)
$statusCode:=HTTP Request:C1158(HTTP POST method:K71:2; $url; $content; $response)

$0:=New object:C1471
OB SET:C1220($0; "response"; $response; "status"; $statusCode)