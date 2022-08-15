//%attributes = {}
ARRAY TEXT:C222($credentials; 2)
C_OBJECT:C1216($accessToken)
C_TEXT:C284($environment; $existingEnvironment)
$existingEnvironment:=BisN_getEnvironment

//testing the test account
setKeyValue("BisN.environment"; "test")
BisN_getClientIdAndSecret(->$credentials)
C_BOOLEAN:C305($isSuccess)
$isSuccess:=BisN_getNewAccessToken(->$credentials; ->$accessToken)
ASSERT:C1129($isSuccess=True:C214; "Failed obtaining test access token")
//{access_token:abcd,token_type:Bearer,expires_in:3599}
ASSERT:C1129(Not:C34($accessToken.access_token=Null:C1517); "Expected access_token to be set for token object")
ASSERT:C1129(Not:C34($accessToken.token_type=Null:C1517); "Expected token_type to be set for token object")
ASSERT:C1129(Not:C34($accessToken.expires_in=Null:C1517); "Expected expires_in to be set for token object")

//testing the prod environment
setKeyValue("BisN.environment"; "prod")
BisN_getClientIdAndSecret(->$credentials)
C_BOOLEAN:C305($isSuccess)
$isSuccess:=BisN_getNewAccessToken(->$credentials; ->$accessToken)
ASSERT:C1129($isSuccess=True:C214; "Failed obtaining prod access token")
//{access_token:abcd,token_type:Bearer,expires_in:3599}
ASSERT:C1129(Not:C34($accessToken.access_token=Null:C1517); "Expected access_token to be set for token object")
ASSERT:C1129(Not:C34($accessToken.token_type=Null:C1517); "Expected token_type to be set for token object")
ASSERT:C1129(Not:C34($accessToken.expires_in=Null:C1517); "Expected expires_in to be set for token object")

setKeyValue("BisN.environment"; $existingEnvironment)

