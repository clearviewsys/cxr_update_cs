//%attributes = {}
//test method for BisnodeCI_deserializeErrorResp
C_TEXT:C284($errorResponseJson)
ARRAY OBJECT:C1221($errorObjArr; 0)


$errorResponseJson:="{\"status\":400,\"statusText\":\"BAD_REQUEST\",\"timestamp\":\"2019-10-01T06:30:59.542\",\"message\":{\"status\":400,\"statusText\":\"BAD_REQUEST\",\"timestamp\":\"2019-10-01T06:30:59.541\",\"message\":\"Invalid Country, sourceCountryCode=SEsdfsf is invalid\"}}"
BisN_deserializeErrResponse($errorResponseJson; ->$errorObjArr)
ASSERT:C1129(Size of array:C274($errorObjArr)=1; "Expected one element in the array")
ASSERT:C1129($errorObjArr{1}.message.status=400; "Expected 400 as status")
ASSERT:C1129($errorObjArr{1}.message.statusText="BAD_REQUEST"; "Expected BAD_REQUEST as statusText")
ASSERT:C1129($errorObjArr{1}.message.timestamp="2019-10-01T06:30:59.541"; "Expected \"2019-10-01T06:30:59.541\" as timestamp")
ASSERT:C1129($errorObjArr{1}.message.message="Invalid Country, sourceCountryCode=SEsdfsf is invalid"; "Expected \"Invalid Country, sourceCountryCode=SEsdfsf is invalid\" as message")