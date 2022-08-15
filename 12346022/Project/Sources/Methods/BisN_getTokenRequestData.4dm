//%attributes = {}
//author: Amir
//7th Oct 2019
//this method is used for BisnodeCI_getNewAccessToken, to get parameters relevant to prod or test environment
//void := BisnodeCI_getTokenRequestData(
//->array text to be filled with requestData, and auth url)

ASSERT:C1129(Type:C295($1)=Is pointer:K8:14; "Expected a pointer to text array")
ASSERT:C1129(Type:C295($1->)=Text array:K8:16; "Expected a pointer to text array")
C_TEXT:C284($environment)
$environment:=BisN_getEnvironment
If ($environment="test")
	APPEND TO ARRAY:C911($1->; "grant_type=client_credentials&scope=bci-test")
End if 

If ($environment="prod")
	APPEND TO ARRAY:C911($1->; "grant_type=client_credentials&scope=bci")
End if 

APPEND TO ARRAY:C911($1->; "https://login.bisnode.com/as/token.oauth2")

