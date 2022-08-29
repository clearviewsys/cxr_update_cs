//%attributes = {}
//author: Amir
//26th March 2020
//returns distance between two coordinates (lat,long) in meters (metric unit)
//success<C_BOOLEAN> := Address_GetDistanceGoogle(objectA<C_OBJECT> ; 
//                                                objectB<C_OBJECT>; 
//                                                object to store result in <C_OBJECT>;
//                                                object to store error in <C_OBJECT>;
//                                                (optional)Google API key <text>: use getkeyValue("Google.geocode.api.key"))
//objectA and objectB should have properties lat, lng in degrees
//TBD: IF NEEDED, FIND WAYS TO SEARCH FOR SHORTEST DISTANCE. DURING TESTS, IT WAS NOTED THAT IT RETURNS DIFFERENT RESULTS FOR SAME TWO LOCATIONS.

// Unit test is written @Zoya

C_OBJECT:C1216($1; $pointA)
C_OBJECT:C1216($2; $pointB)
C_OBJECT:C1216($3; $resultObject)
C_OBJECT:C1216($4; $errorObject)
C_TEXT:C284($5; $googleApiKey)
C_BOOLEAN:C305($0; $success)

Case of 
	: (Count parameters:C259=5)
		$pointA:=$1
		$pointB:=$2
		$resultObject:=$3
		$errorObject:=$4
		$googleApiKey:=$5
	: (Count parameters:C259=4)
		$pointA:=$1
		$pointB:=$2
		$resultObject:=$3
		$errorObject:=$4
		$googleApiKey:=getKeyValue("Google.geocode.api.key"; "")
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$pointA:=$1
$pointB:=$2

ASSERT:C1129(Type:C295($pointA)=Is object:K8:27; "Expected object for point A")
ASSERT:C1129(Type:C295($pointB)=Is object:K8:27; "Expected object for point B")
ASSERT:C1129($pointA#Null:C1517; "Expected not null for point A")
ASSERT:C1129($pointB#Null:C1517; "Expected not null for point B")
ASSERT:C1129($pointA.lat#Null:C1517; "Expected lat (latitude) property for point A")
ASSERT:C1129($pointB.lat#Null:C1517; "Expected lat (latitude) property for point B")
ASSERT:C1129($pointA.lng#Null:C1517; "Expected lng (longitude) property for point A")
ASSERT:C1129($pointB.lng#Null:C1517; "Expected lng (longitude) property for point B")
ASSERT:C1129($resultObject#Null:C1517; "Expected not null for result object")
ASSERT:C1129($errorObject#Null:C1517; "Expected not null for error object")
ASSERT:C1129(Type:C295($resultObject)=Is object:K8:27; "Expected object to store result in")
ASSERT:C1129(Type:C295($errorObject)=Is object:K8:27; "Expected object to store error in")
ASSERT:C1129(Type:C295($googleApiKey)=Is text:K8:3; "Expected text for Google API key")
ASSERT:C1129($googleApiKey#""; "Expected non-empty text for google API key")

ARRAY TEXT:C222($headerNamesArr; 1)
ARRAY TEXT:C222($headerValuesArr; 1)
$headerNamesArr{1}:="Content-Type"
$headerValuesArr{1}:="text/html"

HTTP SET OPTION:C1160(HTTP timeout:K71:10; 5)
C_TEXT:C284($url; $response)
C_LONGINT:C283($httpStatus)

$url:="https://maps.googleapis.com/maps/api/distancematrix/json?units=metric"
$url:=$url+"&origins="+String:C10($pointA.lat)+","+String:C10($pointA.lng)
$url:=$url+"&destinations="+String:C10($pointB.lat)+","+String:C10($pointB.lng)
$url:=$url+"&key="+$googleApiKey

setErrorTrap(Current method name:C684; "Error connecting to distance Google API service")
$httpStatus:=HTTP Get:C1157($url; $response; $headerNamesArr; $headerValuesArr)
endErrorTrap
C_OBJECT:C1216($responseObj)
$responseObj:=JSON Parse:C1218($response)
If (($httpStatus#200) | Not:C34(Undefined:C82($responseObj.error_message)))
	$success:=False:C215
	$errorObject.error_message:="Error connecting to Google Distance API: "+String:C10($responseObj.error_message)
Else 
	ARRAY OBJECT:C1221($arrResponseRows; 0)
	ARRAY OBJECT:C1221($arrResponseElements; 0)
	JSON PARSE ARRAY:C1219(JSON Stringify:C1217($responseObj.rows); $arrResponseRows)
	If ((Size of array:C274($arrResponseRows)=1) & (OB Is defined:C1231($arrResponseRows{1}; "elements")))
		JSON PARSE ARRAY:C1219(JSON Stringify:C1217($arrResponseRows{1}.elements); $arrResponseElements)
		If ((Size of array:C274($arrResponseElements)=1) & (OB Is defined:C1231($arrResponseElements{1}; "distance")))
			$resultObject.distance:=$arrResponseElements{1}.distance.value
			$resultObject.text:=$arrResponseElements{1}.distance.text
			$success:=True:C214
		Else 
			$success:=False:C215
		End if 
	Else 
		$success:=False:C215
	End if 
	
	If ($success=False:C215)
		$errorObject.error_message:="Error: Did not receive a unique result from Google Distance API"
	End if 
	
End if 

$0:=$success
