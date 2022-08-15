//%attributes = {"shared":true}
// __UNIT_TEST
// Jan 2021

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("CanPostAC_RetrieveDeserial"; Current method name:C684; "API.CanadaPost")

// author: Amir
// 11th Feb 2020
// test method for Canada Post Address Complete API retrieve deserializer
// converted to AJ_Unit test by @waikin

C_TEXT:C284($searchResultXml)
C_BOOLEAN:C305($success)
ARRAY OBJECT:C1221($arrObj; 0)
C_OBJECT:C1216($errorObj)

$searchResultXml:=""
$success:=CanPostAC_RetrieveDeserial(->$arrObj; $searchResultXml; ->$errorObj)

C_TEXT:C284($given)
$given:="Given: "+$searchResultXml
//ASSERT(Size of array($arrObj)=0;"Expected no result for address objects")
AJ_assert($test; Size of array:C274($arrObj); 0; $given; "100-Expected no result for address objects")
//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $success; False:C215; $given; "101-Expected false for success")

$searchResultXml:="Not valid XML"
$given:="Given: "+$searchResultXml
$success:=CanPostAC_RetrieveDeserial(->$arrObj; $searchResultXml; ->$errorObj)
//ASSERT(Size of array($arrObj)=0;"Expected no result for address objects")
AJ_assert($test; Size of array:C274($arrObj); 0; $given; "102-Expected no result for address objects")
//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $success; False:C215; $given; "103- Expected false for success")

$searchResultXml:="<NewDataSet></NewDataSet>"
$given:="Given: "+$searchResultXml
$success:=CanPostAC_RetrieveDeserial(->$arrObj; $searchResultXml; ->$errorObj)
//ASSERT(Size of array($arrObj)=0;"Expected no result for address objects")
AJ_assert($test; Size of array:C274($arrObj); 0; $given; "104- Expected no result for address objects")
//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $success; False:C215; $given; "105- Expected false for success")

$searchResultXml:="<NewDataSet><Data></Data></NewDataSet>"
$given:="Given: "+$searchResultXml
$success:=CanPostAC_RetrieveDeserial(->$arrObj; $searchResultXml; ->$errorObj)
//ASSERT(Size of array($arrObj)=0;"Expected no result for address objects")
AJ_assert($test; Size of array:C274($arrObj); 0; $given; "106- Expected no result for address objects")
//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $success; False:C215; $given; "107- Expected false for success")

$searchResultXml:="<NewDataSet><Data><Error>1001</Error><Description>Id Invalid</Description><Cause>The Id parameter supplied was invalid.</Cause><Resolution>Some resolution</Resolution></Data></NewDataSet>"
$given:="Given: "+$searchResultXml
$success:=CanPostAC_RetrieveDeserial(->$arrObj; $searchResultXml; ->$errorObj)
//ASSERT(Size of array($arrObj)=0;"Expected no result for address objects")
AJ_assert($test; Size of array:C274($arrObj); 0; $given; "108- Expected no result for address objects")
//ASSERT($success=False;"Expected false for success")
AJ_assert($test; $success; False:C215; $given; "109- Expected false for success")

$searchResultXml:="<NewDataSet>  <Data>    <Id>CA|CP|B|6372424</Id>    <DomesticId>6372424</DomesticId>    <Language>ENG</Language>    <LanguageAlternatives>ENG,FRE</LanguageAlternatives>    <Department />    <Company />    <SubBuilding>300</SubBuilding>    <BuildingNum"+"ber>311</Buildi"+"ngNumber>    <BuildingName />    <SecondaryStreet />    <Street>Pender St E</Street>    <Block />    <Neighbourhood />    <District />    <City>Vancouver</City>    <Line1>311 Pender St E</Line1>    <Line2 />    <Line3 />    <Line4 />    <Line5 />    <"+"AdminAreaName />    <AdminAreaCode />    <Province>BC</Province>    <ProvinceName>British Columbia</ProvinceName>    <ProvinceCode>BC</ProvinceCode>    <PostalCode>V6A 1V1</PostalCode>    <CountryName>Canada</CountryName>    <CountryIso2>CA</CountryIs"+"o2>    <CountryIso3>CAN</CountryIso3>    <CountryIsoNumber>124</CountryIsoNumber>    <SortingNumber1 />    <SortingNumber2 />    <Barcode />    <POBoxNumber />    <Label>311 Pender St E\\nVANCOUVER BC V6A 1V1\\nCANADA</Label>    <Type>Residential</Type>"+"    <DataLevel>Premise</DataLevel>  </Data>  <Data>    <Id>CA|CP|B|6372424</Id>    <DomesticId>6372424</DomesticId>    <Language>FRE</Language>    <LanguageAlternatives>ENG,FRE</LanguageAlternatives>    <Department />    <Company />    <SubBuilding />"+"    <BuildingNumber>311</BuildingNumber>    <BuildingName />    <SecondaryStreet />    <Street>Rue Pender E</Street>    <Block />    <Neighbourhood />    <District />    <City>Vancouver</City>    <Line1>311 Rue Pender E</Line1>    <Line2 />    <Line3 "+"/>    <Line4 />    <Line5 />    <AdminAreaName />    <AdminAreaCode />    <Province>BC</Province>    <ProvinceName>Colombie-Britannique</ProvinceName>    <ProvinceCode>BC</ProvinceCode>    <PostalCode>V6A 1V1</PostalCode>    <CountryName>Canada</Count"+"ryName>    <CountryIso2>CA</CountryIso2>    <CountryIso3>CAN</CountryIso3>    <CountryIsoNumber>124</CountryIsoNumber>    <SortingNumber1 />    <SortingNumber2 />    <Barcode />    <POBoxNumber />    <Label>311 Rue Pender E\\nVANCOUVER BC V6A 1V1\\nCANA"+"DA</Label>    <Type>Residential</Type>    <DataLevel>Premise</DataLevel>  </Data></NewDataSet>"
$given:="Given: "+$searchResultXml
$success:=CanPostAC_RetrieveDeserial(->$arrObj; $searchResultXml; ->$errorObj)
//ASSERT($success=True;"Expected true for success")
AJ_assert($test; $success; True:C214; $given; "110- Expected true for success")
//ASSERT(Size of array($arrObj)=2;"Expected 2 address objects in the array")
AJ_assert($test; Size of array:C274($arrObj); 2; $given; "111- Expected 2 address objects in the array")

C_OBJECT:C1216($address1)
$address1:=$arrObj{1}

//ASSERT($address1.id="CA|CP|B|6372424";"Expectation failed for matching ID")
//ASSERT($address1.language="ENG";"Expectation failed for matching Language")
//ASSERT($address1.department="";"Expectation failed for matching Department")
//ASSERT($address1.company="";"Expectation failed for matching Company")
//ASSERT($address1.buildingNumber="311";"Expectation failed for matching Building Number")
//ASSERT($address1.unitNumber="300";"Expectation failed for matching Unit Number")
//ASSERT($address1.street="Pender St E";"Expectation failed for matching Street")
//ASSERT($address1.city="Vancouver";"Expectation failed for matching City")
//ASSERT($address1.line1="311 Pender St E";"Expectation failed for matching Line 1")
//ASSERT($address1.line2="";"Expectation failed for matching Line 2")
//ASSERT($address1.provinceName="British Columbia";"Expectation failed for matching Province Name")
//ASSERT($address1.postalCode="V6A 1V1";"Expectation failed for matching Postal Code")
//ASSERT($address1.countryName="Canada";"Expectation failed for matching Country Name")
//ASSERT($address1.poBoxNumber="";"Expectation failed for matching PO BOX Number")
//ASSERT($address1.label#"";"Expectation failed for matching Label")
//ASSERT($address1.type="Residential";"Expectation failed for matching Address Type")
//ASSERT($address1.countryIso2="CA";"Expectation failed for country code")

AJ_assert($test; $address1.id; "CA|CP|B|6372424"; $given; "1- Expectation failed for matching ID")
AJ_assert($test; $address1.language; "ENG"; $given; "2- Expectation failed for matching Language")
AJ_assert($test; $address1.department; ""; $given; "3- Expectation failed for matching Department")
AJ_assert($test; $address1.company; ""; $given; "4- Expectation failed for matching Company")
AJ_assert($test; $address1.buildingNumber; "311"; $given; "5- Expectation failed for matching Building Number")
AJ_assert($test; $address1.unitNumber; "300"; $given; "6- Expectation failed for matching Unit Number")
AJ_assert($test; $address1.street; "Pender St E"; $given; "7- Expectation failed for matching Street")
AJ_assert($test; $address1.city; "Vancouver"; $given; "8- Expectation failed for matching City")
AJ_assert($test; $address1.line1; "311 Pender St E"; $given; "9- Expectation failed for matching Line 1")
AJ_assert($test; $address1.line2; ""; $given; "10 - Expectation failed for matching Line 2")
AJ_assert($test; $address1.provinceName; "British Columbia"; $given; "11- Expectation failed for matching Province Name")
AJ_assert($test; $address1.postalCode; "V6A 1V1"; $given; "12- Expectation failed for matching Postal Code")
AJ_assert($test; $address1.countryName; "Canada"; $given; "13- Expectation failed for matching Country Name")
AJ_assert($test; $address1.poBoxNumber; ""; $given; "14- Expectation failed for matching PO BOX Number")
AJ_assert($test; $address1.label#""; True:C214; $given; "15- Expectation failed for matching Label (not empty)")  // fixed by @tiran
AJ_assert($test; $address1.type; "Residential"; $given; "16- Expectation failed for matching Address Type")
AJ_assert($test; $address1.countryIso2; "CA"; $given; "17- Expectation failed for country code")






