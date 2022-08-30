//%attributes = {"shared":true}
// __UNIT_TEST
//test method for error deserialize method
//author: Amir
//16th Feb 2020
C_OBJECT:C1216($test)
C_TEXT:C284($given)

$test:=AJ_UnitTest.new("CanPostAC_ErrorDeserial"; Current method name:C684; "API.CanadaPost")

C_TEXT:C284($errorResultXml)
C_BOOLEAN:C305($success)
C_OBJECT:C1216($errorObj)

$errorResultXml:=""
$success:=CanPostAC_ErrorDeserial(->$errorObj; $errorResultXml)
$given:="calling CanPostAC_ErrorDeserial"
//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $success; False:C215; $given; "success = false")

//ASSERT($errorObj=Null;"Expected null for error object")
AJ_assert($test; $errorObj=Null:C1517; True:C214; $given; "errorObj= null")


$errorResultXml:="Not valid xml"
$success:=CanPostAC_ErrorDeserial(->$errorObj; $errorResultXml)
//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $success; False:C215; $given; "Expected false for success")
//ASSERT($errorObj=Null;"Expected null for error object")
AJ_assert($test; $errorObj=Null:C1517; True:C214; $given; "Expected null for error object")

$errorResultXml:="<NewDataSet></NewDataSet>"
$success:=CanPostAC_ErrorDeserial(->$errorObj; $errorResultXml)
//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $success; False:C215; $given; "Expected false for success")
//ASSERT($errorObj=Null;"Expected null for error object")
AJ_assert($test; $errorObj=Null:C1517; True:C214; $given; "Expected null for error object")

$errorResultXml:="<NewDataSet><Data></Data></NewDataSet>"
$success:=CanPostAC_ErrorDeserial(->$errorObj; $errorResultXml)
//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $errorObj=Null:C1517; True:C214; $given; "Expected null for error object")
//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $errorObj=Null:C1517; True:C214; $given; "Expected null for error object")

$errorResultXml:="<NewDataSet>\\r\\n  <Data>\\r\\n    <Error>1003</Error>\\r\\n    <Description>Country Invalid</Description>\\r\\n    <Cause>The Country parameter was not recognised. Check the spelling and, if in doubt, use a valid ISO 2 or 3 digit country code.</Cause>\\r\\n  "+"  <Resolution>Provide a valid ISO 2 or 3 digit country code or use a web service to convert country name to ISO code.</Resolution>\\r\\n  </Data>\\r\\n</NewDataSet>"
$success:=CanPostAC_ErrorDeserial(->$errorObj; $errorResultXml)
C_OBJECT:C1216($expected)
$expected:=New object:C1471
$expected.errorCode:="1003"
$expected.errorDescription:="Country Invalid"
$expected.errorCause:="The Country parameter was not recognised. Check the spelling and, if in doubt, use a valid ISO 2 or 3 digit country code."
$expected.errorResolution:="Provide a valid ISO 2 or 3 digit country code or use a web service to convert country name to ISO code."

//ASSERT($success=True;"Expected true for success")
AJ_assert($test; $success; True:C214; $given; "Expected true for success")
//ASSERT($errorObj#Null;true;$given;"Expected non-null object for error object")
AJ_assert($test; $errorObj#Null:C1517; True:C214; $given; "Expected non-null object for error object")

AJ_assert($test; $errorObj; $expected; $given; "we should get "+JSON Stringify:C1217($expected))
/*
ASSERT($errorObj.errorCode="1003";"Expectation failed for error code")
ASSERT($errorObj.errorDescription="Country Invalid";"Expectation failed for error description")
ASSERT($errorObj.errorCause="The Country parameter was not recognised. Check the spelling and, if in doubt, use a valid ISO 2 or 3 digit country code.";"Expectation failed for error cause")
ASSERT($errorObj.errorResolution="Provide a valid ISO 2 or 3 digit country code or use a web service to convert country name to ISO code.")
