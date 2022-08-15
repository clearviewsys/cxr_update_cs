//%attributes = {}
//author: Amir
//24th Sept 2019
//fills given array text pointer with client id and secret
//BisnodeCI_getClientIdAndSecret(
//->array text: to be filled with client id and secret, depending on the test or prod environment)
C_TEXT:C284($environment)

$environment:=BisN_getEnvironment

C_POINTER:C301($1)
ASSERT:C1129(Type:C295($1->)=Text array:K8:16; "Expected text array")
ASSERT:C1129(Size of array:C274($1->)=2; "Expected text array with length 2")

C_TEXT:C284($clientId; $clientSecret)

Case of 
	: ($environment="test")
		$clientId:=getKeyValue("BisN.test.client.id"; "empty")
		$clientSecret:=getKeyValue("BisN.test.client.secret"; "empty")
	: ($environment="prod")
		$clientId:=getKeyValue("BisN.prod.client.id"; "empty")
		$clientSecret:=getKeyValue("BisN.prod.client.secret"; "empty")
End case 
ASSERT:C1129(Not:C34(($clientId="empty")) & Not:C34(($clientSecret="empty")); "client_id or client_secret key value is not set for the environment: "+String:C10($environment))


$1->{1}:=$clientId
$1->{2}:=$clientSecret

