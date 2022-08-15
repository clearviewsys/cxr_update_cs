//%attributes = {"shared":true}
// __UNIT_TEST
// written by @amir
// modified by @tiran 
//Dec 2020

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("googleGeocodeAddressObj"; Current method name:C684; "API.GoogleMap")

//test method for googleGeocodeAddressObj
C_BOOLEAN:C305($success)
C_OBJECT:C1216($addressObj; $errorObj)
$addressObj:=newAddress("CA"; "BC"; "Victoria"; "V8N 4C4"; "3844 Hobbs St"; "")
$errorObj:=New object:C1471

$success:=googleGeocodeAddressObj($addressObj; $errorObj)
C_TEXT:C284($given)
$given:="caling googleGeocodeAddressObj($addressObj;$errorObj)"
//ASSERT($success=True)

AJ_assert($test; $success; True:C214; $given; "should return true for success")

//ASSERT(OB Is defined($addressObj;"lat"))
AJ_assert($test; OB Is defined:C1231($addressObj; "lat")=True:C214; True:C214; $given; "addressObj.lat should be defined")

//ASSERT(OB Is defined($addressObj;"lng"))
AJ_assert($test; OB Is defined:C1231($addressObj; "lng")=True:C214; True:C214; $given; "addressObj.Ing should be defined")

If (OB Is defined:C1231($addressObj; "lat"))
	//ASSERT($addressObj.lat=48.4626156)
	AJ_assert($test; $addressObj.lat; 48.4626156; $given; "$addressObj.lat ==48.4626156 ")
End if 

If (OB Is defined:C1231($addressObj; "lng"))
	//ASSERT($addressObj.lng=-123.2986559)
	AJ_assert($test; $addressObj.lng; -123.2986559; $given; "addressObj.lng == -123.2986559")
End if 