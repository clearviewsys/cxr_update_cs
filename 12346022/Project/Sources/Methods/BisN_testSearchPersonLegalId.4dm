//%attributes = {}
//test method for BsndCI_searchPersonByLegalId
C_BOOLEAN:C305($isSuccess)
ARRAY OBJECT:C1221($arrPersonObj; 0)

C_TEXT:C284($existingEnvironment)
$existingEnvironment:=BisN_getEnvironment
setKeyValue("BisN.environment"; "test")

$isSuccess:=BisN_searchPersonByLegalId(->$arrPersonObj; "1234567890123")
//response: {status:400,statusText:BAD_REQUEST,timestamp:2019-11-10T02:24:54.622,message:legalId is not valid!}
ASSERT:C1129($isSuccess=False:C215; "Expected false as status")
ASSERT:C1129(Size of array:C274($arrPersonObj)=1; "Expected one element in error response")
ASSERT:C1129($arrPersonObj{1}.status=400; "Expected 400 as response status code")
ASSERT:C1129($arrPersonObj{1}.statusText="BAD_REQUEST"; "Expected 'BAD_REQUEST' as status text")
ASSERT:C1129($arrPersonObj{1}.message="legalId is not valid!"; "Expected 'legalId is not valid!' as message")

ARRAY OBJECT:C1221($arrPersonObj; 0)
$isSuccess:=BisN_searchPersonByLegalId(->$arrPersonObj; "1985082663085")
//{firstNames:[Bertil,Östen],preferredFirstName:Bertil,familyName:Änglund,dateOfBirth:1985-08-26T00:00:00.000Z,yearOfBirth:1985,deceased:false,phoneList:[],addressList:[{type:Postal,careOf:Jimmy Hendricks,streetName:Elisabeths Väg,streetNumber:142,entrance:,apartment:1404,floor:4,postOfficeBox:254,postalCode:60065,city:Kungby,country:SE,formattedAddress:[℅ Jimmy Hendricks,Elisabeths Väg 142  lgh 1404,60065 Kungby]},{type:Postal,careOf:Jimmy Hendricks,streetName:Kyrkovägen,streetNumber:87,entrance:A,apartment:1103,floor:1,postOfficeBox:542,postalCode:27143,city:Gävås,country:SE,formattedAddress:[℅ Jimmy Hendricks,Kyrkovägen 87 A lgh 1103,27143 Gävås]}]}
ASSERT:C1129($isSuccess=True:C214; "Expected true as status")
ASSERT:C1129(Size of array:C274($arrPersonObj)=1; "Expected array of one objects")

ARRAY TEXT:C222($firstNames; 0)
OB GET ARRAY:C1229($arrPersonObj{1}; "firstNames"; $firstNames)
ASSERT:C1129($firstNames{1}="Bertil"; "Expected 'Bertil' as one of firstNames")
ASSERT:C1129($firstNames{2}="Östen"; "Expected 'Östen' as one of firstNames")
ASSERT:C1129($arrPersonObj{1}.preferredFirstName="Bertil"; "Expected 'Bertil' as preferred first name")
ASSERT:C1129($arrPersonObj{1}.familyName="Änglund"; "Expected 'Änglund' as familyName")
ASSERT:C1129($arrPersonObj{1}.dateOfBirth="1985-08-26"; "Expectation failed for dateOfBirth")
ASSERT:C1129($arrPersonObj{1}.yearOfBirth=1985; "Expectation failed for yearOfBirth")
ASSERT:C1129($arrPersonObj{1}.deceased=False:C215; "Expectation failed for deceased property")

ARRAY OBJECT:C1221($phoneList; 0)
OB GET ARRAY:C1229($arrPersonObj{1}; "phoneList"; $phoneList)
ASSERT:C1129(Size of array:C274($phoneList)=0; "Expected empty 'phoneList' array")

ARRAY OBJECT:C1221($addressList; 0)
OB GET ARRAY:C1229($arrPersonObj{1}; "addressList"; $addressList)
ASSERT:C1129(Size of array:C274($addressList)=2; "Expected 2 addresses")
ASSERT:C1129($addressList{1}.type="Postal"; "Expectation failed for address type")
ASSERT:C1129($addressList{1}.careOf="Jimmy Hendricks"; "Expectation failed for address careOf")
ASSERT:C1129($addressList{1}.streetName="Elisabeths Väg"; "Expectation failed for address streetName")
ASSERT:C1129($addressList{1}.streetNumber="142"; "Expectation failed for address streetNumber")
ASSERT:C1129($addressList{1}.apartment="1404"; "Expectation failed for address apartment")
ASSERT:C1129($addressList{1}.floor="4"; "Expectation failed for address floor")
ASSERT:C1129($addressList{1}.postOfficeBox="254"; "Expectation failed for address postOfficeBox")
ASSERT:C1129($addressList{1}.postalCode="60065"; "Expectation failed for address postalCode")
ASSERT:C1129($addressList{1}.city="Kungby"; "Expectation failed for address city")
ASSERT:C1129($addressList{1}.country="SE"; "Expectation failed for address country")

ASSERT:C1129($addressList{2}.streetNumber="87"; "Expectation failed for address streetNumber")

setKeyValue("BisN.environment"; $existingEnvironment)
