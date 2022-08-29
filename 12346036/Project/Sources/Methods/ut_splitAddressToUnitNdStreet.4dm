//%attributes = {"shared":true}
// __UNIT_TEST
// written by @nora
// Jan 2021


C_OBJECT:C1216($addressObj)
C_TEXT:C284($result; $given)

C_COLLECTION:C1488($testData)
$testData:=New collection:C1472
$testData[0]:=New object:C1471("input"; ""; "expectedStreetAddress"; ""; "expectedUnitNumber"; "")
$testData[1]:=New object:C1471("input"; "123 test street"; "expectedStreetAddress"; "123 test street"; "expectedUnitNumber"; "")
$testData[2]:=New object:C1471("input"; "100 , 123 test street"; "expectedStreetAddress"; "123 test street"; "expectedUnitNumber"; "100")
$testData[3]:=New object:C1471("input"; "100 - 123 test street"; "expectedStreetAddress"; "123 test street"; "expectedUnitNumber"; "100")
$testData[4]:=New object:C1471("input"; "100-123 test street"; "expectedStreetAddress"; "123 test street"; "expectedUnitNumber"; "100")
$testData[5]:=New object:C1471("input"; "123 test street, unit 100"; "expectedStreetAddress"; "123 test street"; "expectedUnitNumber"; "100")
$testData[6]:=New object:C1471("input"; "unit 100 , 123 test street"; "expectedStreetAddress"; "123 test street"; "expectedUnitNumber"; "100")
$testData[7]:=New object:C1471("input"; "123 test street, unit number 100"; "expectedStreetAddress"; "123 test street"; "expectedUnitNumber"; "100")
$testData[8]:=New object:C1471("input"; "UNIT NUMBER 100, 123 test street"; "expectedStreetAddress"; "123 test street"; "expectedUnitNumber"; "100")
$testData[9]:=New object:C1471("input"; "123 test street, suite 100"; "expectedStreetAddress"; "123 test street"; "expectedUnitNumber"; "100")
$testData[10]:=New object:C1471("input"; "123 test street, suite number 100"; "expectedStreetAddress"; "123 test street"; "expectedUnitNumber"; "100")
$testData[11]:=New object:C1471("input"; "100/123 test street"; "expectedStreetAddress"; "123 test street"; "expectedUnitNumber"; "100")
$testData[12]:=New object:C1471("input"; "100, 123, test street"; "expectedStreetAddress"; "100, 123, test street"; "expectedUnitNumber"; "")
$testData[13]:=New object:C1471("input"; "2 Toronto St, Apt 909"; "expectedStreetAddress"; "2 Toronto St"; "expectedUnitNumber"; "909")
$testData[14]:=New object:C1471("input"; "2 Toronto St, apartment 909"; "expectedStreetAddress"; "2 Toronto St"; "expectedUnitNumber"; "909")

//when cannot find unit number, should return entire address
$testData[15]:=New object:C1471("input"; "2 Toronto St, Appartmente 909"; "expectedStreetAddress"; "2 Toronto St, Appartmente 909"; "expectedUnitNumber"; "")


C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("splitAddressToUnitNdStreet"; Current method name:C684; "API.GoogleMap")

C_OBJECT:C1216($testAddress)
For each ($testAddress; $testData)
	$addressObj:=splitAddressToUnitAndStreet($testAddress.input)
	$given:=JSON Stringify:C1217($addressObj)
	$result:=JSON Stringify:C1217($testAddress.input)
	// Order of parameters: test, actual, exp, given, should
	AJ_assert($test; $addressObj.streetAddress; $testAddress.expectedStreetAddress; $given; "Expectation for streetAddress failed for input "+$result)
	AJ_assert($test; $addressObj.unitNumber; $testAddress.expectedUnitNumber; $given; "Expectation for unitNumber failed for input "+$result)
	
	//ASSERT($addressObj.streetAddress=$testAddress.expectedStreetAddress;"Expectation for streetAddress failed for input "+$testAddress.input)
	//ASSERT($addressObj.unitNumber=$test.expectedUnitNumber;"Expectation for unitNumber failed for input "+$test.input)
End for each 
