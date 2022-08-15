//%attributes = {"shared":true}
// __UNIT_TEST

//test method for CanPostAC_SearchDeserializer
//author: Amir
// revamped by @tiran on Dec 2020

//22nd Jan 2020

C_TEXT:C284($searchResultXml)
C_BOOLEAN:C305($success)
C_OBJECT:C1216($errorObj)
ARRAY OBJECT:C1221($arrObj; 0)
C_TEXT:C284($given)

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("CanPost_AC_Deserial"; Current method name:C684; "API.CanadaPost")

$searchResultXml:=""
$success:=CanPostAC_SearchDeserial(->$arrObj; $searchResultXml; ->$errorObj)
//ASSERT(Size of array($arrObj)=0;"Expected no result for address objects")
//ASSERT($success=False;"Expected false for success")
AJ_assert($test; Size of array:C274($arrObj); 0; "empty call to the API "; "Expect 0 result for address in the object arrary")
AJ_assert($test; $success; False:C215; "empty call to the API"; "Expect false for success")

$searchResultXml:="Not valid XML"
$errorObj:=Null:C1517
$success:=CanPostAC_SearchDeserial(->$arrObj; $searchResultXml; ->$errorObj)
//ASSERT(Size of array($arrObj)=0;"Expected no result for address objects")
AJ_assert($test; Size of array:C274($arrObj); 0; "empty call to the API "; "Expect 0 result for address in the object arrary")

//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $success; False:C215; "empty call to the API"; "Expect false for success")

//ASSERT($errorObj.errorCause="Search response parse error";"Expectation failed for matching error")
AJ_assert($test; $errorObj.errorCause; "Search response parse error"; "empty call to the API"; "Search response parse error")

//ASSERT($errorObj.errorDescription="API of Canada Post returned an invalid xml that we couldn't parse";"Expectation failed for matching error description")
AJ_assert($test; $errorObj.errorDescription; "API of Canada Post returned an invalid xml that we couldn't parse"; "empty call to the API"; "Expectation failed for matching error description")

$searchResultXml:="<NewDataSet></NewDataSet>"
$errorObj:=Null:C1517
$success:=CanPostAC_SearchDeserial(->$arrObj; $searchResultXml; ->$errorObj)

//ASSERT(Size of array($arrObj)=0;"Expected no result for address objects")
AJ_assert($test; Size of array:C274($arrObj); 0; "passing <newDataSet> in the searchResultXML"; "Expected no result for address objects")

//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $success; False:C215; "passing <newDataSet> in the searchResultXML"; "Expected false for success")

//ASSERT($errorObj.errorCause="Search response parse error";"Expectation failed for matching error")
AJ_assert($test; $errorObj.errorCause; "Search response parse error"; "passing <newDataSet> in the searchResultXML"; "Expectation failed for matching error")

//ASSERT($errorObj.errorDescription="API of Canada Post returned an xml that didn't have any records";"Expectation failed for matching error description")
AJ_assert($test; $errorObj.errorDescription; "API of Canada Post returned an xml that didn't have any records"; "passing <newDataSet> in the searchResultXML"; "Expectation failed for matching error description")

$searchResultXml:="<NewDataSet><Data></Data></NewDataSet>"
$errorObj:=Null:C1517
$success:=CanPostAC_SearchDeserial(->$arrObj; $searchResultXml; ->$errorObj)
$given:="Given searchResultXML = "+$searchResultXml

//ASSERT(Size of array($arrObj)=0;"Expected no result for address objects")
AJ_assert($test; Size of array:C274($arrObj); 0; $given; "Expected no result for address objects")

//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $success; False:C215; $given; "Expected false for success")

//ASSERT($errorObj.errorCause="Search response parse error";"Expectation failed for matching error")
AJ_assert($test; $errorObj.errorCause; "Search response parse error"; $given; "Expectation failed for matching error")

//ASSERT($errorObj.errorDescription="API of Canada Post returned an xml that didn't have any records";"Expectation failed for matching error description")
AJ_assert($test; $errorObj.errorDescription; "API of Canada Post returned an xml that didn't have any records"; $given; "Expectation failed for matching error description")


$searchResultXml:="<NewDataSet><Data><Error>1003</Error><Description>Country Invalid</Description><Cause>Country invalid</Cause><Resolution>some resolution</Resolution></Data></NewDataSet>"
$errorObj:=Null:C1517
$success:=CanPostAC_SearchDeserial(->$arrObj; $searchResultXml; ->$errorObj)
$given:="Given searchResultXML = "+$searchResultXml

//ASSERT(Size of array($arrObj)=0;"Expected no result for address objects")
AJ_assert($test; Size of array:C274($arrObj); 0; $given; "Expected no result for address objects")

//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $success; False:C215; $given; "Expected false for success")

//ASSERT($errorObj.errorCode="1003")
AJ_assert($test; $errorObj.errorCode; "1003"; $given; "Expected 1003 error code")

//ASSERT($errorObj.errorDescription="Country Invalid")
AJ_assert($test; $errorObj.errorDescription; "Country Invalid"; $given; "Error Description should be Country Invalid")

//ASSERT($errorObj.errorCause="Country invalid")
AJ_assert($test; $errorObj.errorCause; "Country invalid"; $given; "Country Valid")

//ASSERT($errorObj.errorResolution="some resolution")
AJ_assert($test; $errorObj.errorResolution; "some resolution"; $given; "some resolution")

$searchResultXml:="<NewDataSet><Data>\r<Id>CA|CP|B|6372424</Id>\r<Text>311 Pender St E</Text>\r<Highlight>0-3,4-10</Highlight>\r<Cursor>0</Cursor>\r<Description>Vancouver, BC, V6A 1V1</Description>\r<Next>Retrieve</Next>\r</Data>\r<Data>\r<Id>CA|CP|ENG|BC-VANCOUVER-PENDER_ST_W-3"+"11</Id>\r<Text>311 Pender St W</Text>\r<Highlight>0-3,4-10</Highlight>\r<Cursor>0</Cursor>\r<Description>Vancouver, BC, V6B 1T3 - 3 Addresses</Description>\r<Next>Find</Next>\r</Data>\r<Data>\r<Id>CA|CP|B|3482613</Id>\r<Text>311-4424 Pender St</Text>\r<Highligh"+"t>0-3,9-15</Highlight>\r<Cursor>0</Cursor>\r<Description>Burnaby, BC, V5C 2M7</Description>\r<Next>Retrieve</Next>\r</Data>\r</NewDataSet>"
$errorObj:=Null:C1517
$success:=CanPostAC_SearchDeserial(->$arrObj; $searchResultXml; ->$errorObj)

$given:="Given searchResultXML = "+$searchResultXml


//ASSERT($success=True;"Expected true for success")
AJ_assert($test; $success; True:C214; $given; "Expected true for success")

//ASSERT(Size of array($arrObj)=3;"Expected 3 address objects in the array")
AJ_assert($test; Size of array:C274($arrObj); 3; $given; "Expected 3 address objects in the array")

//ASSERT($errorObj=Null;"Expected no error from parsing")
AJ_assert($test; $errorObj=Null:C1517; True:C214; $given; "Expected no error from parsing")


C_OBJECT:C1216($address; $expected)

$address:=$arrObj{1}

$expected:=New object:C1471

$expected.id:="CA|CP|B|6372424"
$expected.text:="311 Pender St E"
$expected.description:="Vancouver, BC, V6A 1V1"
$expected.action:="Retrieve"

//ASSERT($address1.id="CA|CP|B|6372424";"Address ID not parsed correctly")
//ASSERT($address1.text="311 Pender St E";"Address text not parsed correctly")
//ASSERT($address1.description="Vancouver, BC, V6A 1V1";"Address description not parsed correctly")
//ASSERT($address1.action="Retrieve";"Address next action not parsed correctly")
$given:="Given searchResultXML = "+$searchResultXml

AJ_assert($test; $address; $expected; $given; JSON Stringify:C1217($expected))

//C_OBJECT($address2)
//$address2:=$arrObj{2}
//ASSERT($address2.id="CA|CP|ENG|BC-VANCOUVER-PENDER_ST_W-311";"Address ID not parsed correctly")
//ASSERT($address2.text="311 Pender St W";"Address text not parsed correctly")
//ASSERT($address2.description="Vancouver, BC, V6B 1T3 - 3 Addresses";"Address description not parsed correctly")
//ASSERT($address2.action="Find";"Address next action not parsed correctly")

$address:=$arrObj{2}
$expected.id:="CA|CP|ENG|BC-VANCOUVER-PENDER_ST_W-311"
$expected.text:="311 Pender St W"
$expected.description:="Vancouver, BC, V6B 1T3 - 3 Addresses"
$expected.action:="Find"
AJ_assert($test; $address; $expected; "Passing "+$searchResultXml; JSON Stringify:C1217($expected))


/*
C_OBJECT($address3)
$address3:=$arrObj{3}
ASSERT($address3.id="CA|CP|B|3482613";"Address ID not parsed correctly")
ASSERT($address3.text="311-4424 Pender St";"Address text not parsed correctly")
ASSERT($address3.description="Burnaby, BC, V5C 2M7";"Address description not parsed correctly")
ASSERT($address3.action="Retrieve";"Address next action not parsed correctly")
*/

$address:=$arrObj{3}
$expected.id:="CA|CP|B|3482613"
$expected.text:="311-4424 Pender St"
$expected.description:="Burnaby, BC, V5C 2M7"
$expected.action:="Retrieve"

AJ_assert($test; $address; $expected; "given address "+JSON Stringify:C1217($address); JSON Stringify:C1217($expected))
