//%attributes = {"shared":true}
// __UNIT_TEST
// written by @amir
// converted by @zoya
// Dec 2020

//test method for CanPostAc_RetrieveAddress

ARRAY OBJECT:C1221($arrAddressObj; 0)
C_TEXT:C284($addressId)
C_OBJECT:C1216($errorObj)
$addressId:="CA|CP|B|6372424"
//$addressId:="CA|CP|ENG|BC-VANCOUVER-PENDER_ST_W-311"
C_BOOLEAN:C305($success)

C_OBJECT:C1216($test)

$test:=AJ_UnitTest.new("CanPostAC_RetrieveAddress"; Current method name:C684; "API.CanadaPost")

$success:=CanPostAC_RetrieveAddress(->$arrAddressObj; $addressId; ->$errorObj)
//success response example: <?xml version="1.0" encoding="UTF-8" ?>\r\n<NewDataSet>\r\n  <Data>\r\n    <Id>CA|CP|B|6372424</Id>\r\n    <DomesticId>6372424</DomesticId>\r\n    <Language>ENG</Language>\r\n    <LanguageAlternatives>ENG,FRE</LanguageAlternatives>\r\n    <Department />\r\n    <Company />\r\n    <SubBuilding />\r\n    <BuildingNumber>311</BuildingNumber>\r\n    <BuildingName />\r\n    <SecondaryStreet />\r\n    <Street>Pender St E</Street>\r\n    <Block />\r\n    <Neighbourhood />\r\n    <District />\r\n    <City>Vancouver</City>\r\n    <Line1>311 Pender St E</Line1>\r\n    <Line2 />\r\n    <Line3 />\r\n    <Line4 />\r\n    <Line5 />\r\n    <AdminAreaName />\r\n    <AdminAreaCode />\r\n    <Province>BC</Province>\r\n    <ProvinceName>British Columbia</ProvinceName>\r\n    <ProvinceCode>BC</ProvinceCode>\r\n    <PostalCode>V6A 1V1</PostalCode>\r\n    <CountryName>Canada</CountryName>\r\n    <CountryIso2>CA</CountryIso2>\r\n    <CountryIso3>CAN</CountryIso3>\r\n    <CountryIsoNumber>124</CountryIsoNumber>\r\n    <SortingNumber1 />\r\n    <SortingNumber2 />\r\n    <Barcode />\r\n    <POBoxNumber />\r\n    <Label>311 Pender St E\nVANCOUVER BC V6A 1V1\nCANADA</Label>\r\n    <Type>Residential</Type>\r\n    <DataLevel>Premise</DataLevel>\r\n  </Data>\r\n  <Data>\r\n    <Id>CA|CP|B|6372424</Id>\r\n    <DomesticId>6372424</DomesticId>\r\n    <Language>FRE</Language>\r\n    <LanguageAlternatives>ENG,FRE</LanguageAlternatives>\r\n    <Department />\r\n    <Company />\r\n    <SubBuilding />\r\n    <BuildingNumber>311</BuildingNumber>\r\n    <BuildingName />\r\n    <SecondaryStreet />\r\n    <Street>Rue Pender E</Street>\r\n    <Block />\r\n    <Neighbourhood />\r\n    <District />\r\n    <City>Vancouver</City>\r\n    <Line1>311 Rue Pender E</Line1>\r\n    <Line2 />\r\n    <Line3 />\r\n    <Line4 />\r\n    <Line5 />\r\n    <AdminAreaName />\r\n    <AdminAreaCode />\r\n    <Province>BC</Province>\r\n    <ProvinceName>Colombie-Britannique</ProvinceName>\r\n    <ProvinceCode>BC</ProvinceCode>\r\n    <PostalCode>V6A 1V1</PostalCode>\r\n    <CountryName>Canada</CountryName>\r\n    <CountryIso2>CA</CountryIso2>\r\n    <CountryIso3>CAN</CountryIso3>\r\n    <CountryIsoNumber>124</CountryIsoNumber>\r\n    <SortingNumber1 />\r\n    <SortingNumber2 />\r\n    <Barcode />\r\n    <POBoxNumber />\r\n    <Label>311 Rue Pender E\nVANCOUVER BC V6A 1V1\nCANADA</Label>\r\n    <Type>Residential</Type>\r\n    <DataLevel>Premise</DataLevel>\r\n  </Data>\r\n</NewDataSet>
//error example: <?xml version="1.0" encoding="UTF-8" ?>\r\n<NewDataSet>\r\n  <Data>\r\n    <Error>1001</Error>\r\n    <Description>Id Invalid</Description>\r\n    <Cause>The Id parameter supplied was invalid.</Cause>\r\n    <Resolution>Try again, using only IDs from the Find services.</Resolution>\r\n  </Data>\r\n</NewDataSet>
AJ_assert($test; $success; True:C214; "Correct ID"; "Expected true for success")
//ASSERT($success=True;"Expected true for success")
//ASSERT(Size of array($arrAddressObj)=2;"Expected two results for the given address ID")
AJ_assert($test; Size of array:C274($arrAddressObj); 2; "two addresses for one ID in resords, one in English one in French"; "Expected two results for the given address ID")
//ASSERT($errorObj=Null;"Expected no error")
AJ_assert($test; $errorObj=Null:C1517; True:C214; "No error is stored"; "Expected no error")

/*ASSERT($arrAddressObj{1}.id="CA|CP|B|6372424";"Expectation failed for matching ID")
ASSERT($arrAddressObj{1}.language="ENG";"Expectation failed for matching Language")
ASSERT($arrAddressObj{1}.department="";"Expectation failed for matching Department")
ASSERT($arrAddressObj{1}.company="";"Expectation failed for matching Company")
ASSERT($arrAddressObj{1}.buildingNumber="311";"Expectation failed for matching Building Number")
ASSERT($arrAddressObj{1}.street="Pender St E";"Expectation failed for matching Street")
ASSERT($arrAddressObj{1}.city="Vancouver";"Expectation failed for matching City")
ASSERT($arrAddressObj{1}.line1="311 Pender St E";"Expectation failed for matching Line 1")
ASSERT($arrAddressObj{1}.line2="";"Expectation failed for matching Line 2")
ASSERT($arrAddressObj{1}.provinceName="British Columbia";"Expectation failed for matching Province Name")
ASSERT($arrAddressObj{1}.postalCode="V6A 1V1";"Expectation failed for matching Postal Code")
ASSERT($arrAddressObj{1}.countryName="Canada";"Expectation failed for matching Country Name")
ASSERT($arrAddressObj{1}.poBoxNumber="";"Expectation failed for matching PO BOX Number")
ASSERT($arrAddressObj{1}.label#"";"Expectation failed for matching Label")
ASSERT($arrAddressObj{1}.type="Residential";"Expectation failed for matching Address Type")
*/
$addressId:="BAD ID"
C_TEXT:C284($given)
$given:="A BAD ID"
ARRAY OBJECT:C1221($arrAddressObj; 0)
C_OBJECT:C1216($errorObj)
$success:=CanPostAC_RetrieveAddress(->$arrAddressObj; $addressId; ->$errorObj)
//ASSERT($success=False;"Expected false for success")
//AJ_assert($test;$success;False;$given;"Expect false for success")
//ASSERT($errorObj.errorCode="1001";"Expectation failed for error code")
//AJ_assert($test;$errorObj.errorCode;"1001";$given;"Expectation failed for error code")
//ASSERT($errorObj.errorDescription="Id Invalid";"Expectation failed for error description")
///AJ_assert($test;$errorObj.errorDescription;"Id Invalid";$given;"Expectation failed for error description")
//ASSERT($errorObj.errorCause="The Id parameter supplied was invalid.";"Expectation failed for error cause")
//AJ_assert($test;$errorObj.errorCause;"The Id parameter supplied was invalid.";$given;"Expectation failed for error cause")
//ASSERT($errorObj.errorResolution="Try again, using only IDs from the Find services.";"Expectation failed for error resolution")
//AJ_assert($test;$errorObj.errorResolution;"Try again, using only IDs from the Find services.";$given;"Expectation failed for error resolution")

C_OBJECT:C1216($expectedError)
$expectedError:=New object:C1471
$expectedError.errorCode:="1001"
$expectedError.errorDescription:="Id Invalid"
$expectedError.errorCause:="The Id parameter supplied was invalid."
$expectedError.errorResolution:="Try again, using only IDs from the Find services."
AJ_assert($test; $errorObj; $expectedError; $given; "The error object should be "+JSON Stringify:C1217($expectedError))

