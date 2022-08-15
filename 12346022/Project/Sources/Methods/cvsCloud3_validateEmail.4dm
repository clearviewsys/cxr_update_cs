//%attributes = {}
//Unit test is written by @Zoya

var $companyInfo; $body; $headers; $response; $0 : Object
var $email; $baseURL; $endpoint; $1 : Text

Case of 
	: (Count parameters:C259=1)
		$email:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$companyInfo:=ds:C1482.CompanyInfo.all().first()
$baseURL:="https://cvscloud3.azurewebsites.net/api"
$endpoint:="/email/validate"

$headers:=New object:C1471()
OB SET:C1220($headers; "Content-Type"; "application/x-www-form-urlencoded")

$body:=New object:C1471()
OB SET:C1220($body; "clientcode"; $companyInfo.ClientCode2)
OB SET:C1220($body; "clientkey"; $companyInfo.ClientKey2)
OB SET:C1220($body; "email"; $email)

$response:=HTTPRequest(HTTP GET method:K71:1; $baseURL+$endpoint; $body; $headers)

$0:=$response