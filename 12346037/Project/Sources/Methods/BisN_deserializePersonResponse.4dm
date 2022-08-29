//%attributes = {}
//author: Amir
//30th Sept 2019
//deserializes the response object into array of person objects

//Example of response object as argument to this function:
//{"persons":[{"memento":"eyJzb3VyY2VEYXRhYmFzZSI6ImNpYS1lbGFzdGljc2VhcmNoIiwidGltZXN0YW1wIjoxNTY5OTA0NzY5NjE3LCJnZW5lcmF0aW9uS2V5IjoiIiwicGVyc29uS2V5IjoiQTJBRTNaODQ2TjdBIn0=","person":{"gedi":"A2AE3Z846N7A","protectedIdentity":false,"firstNames":["Sven","Henning"],"preferredFirstName":"Sven","familyName":"Svensson","dateOfBirth":"1949-09-06","yearOfBirth":1949,"deceased":false,"phoneList":[{"type":"Mobile","number":"+46703520422","telemarketingRestriction":true}],"addressList":[{"type":"Visiting","subType":"Domicile","streetName":"Vasagatan","streetNumber":"5","entrance":"B","apartment":"1202","postalCode":"79530","city":"Rättvik","country":"SE","formattedAddress":["Vasagatan 5 B lgh 1202","79530 Rättvik"]}]},"subscriptionState":{"subscribed":false}}]}
C_TEXT:C284($1; $personResponseJson)
C_POINTER:C301($2; $personObjArrayPtr)

$personResponseJson:=$1
$personObjArrayPtr:=$2

ASSERT:C1129(Type:C295($personResponseJson)=Is text:K8:3; "Expected a text with json format")
ASSERT:C1129(Type:C295($personObjArrayPtr)=Is pointer:K8:14; "Expected pointer to array of object")
ASSERT:C1129(Type:C295($personObjArrayPtr->)=Object array:K8:28; "Expected pointer to array of object")

C_OBJECT:C1216($deserializedReponse)
ARRAY OBJECT:C1221($rawObjArray; 0)
$deserializedReponse:=JSON Parse:C1218($personResponseJson)
JSON PARSE ARRAY:C1219(JSON Stringify:C1217($deserializedReponse.persons); $rawObjArray)

C_LONGINT:C283($i)
C_LONGINT:C283($j)
C_OBJECT:C1216($usefulPersonDataObj)
ARRAY OBJECT:C1221($phoneDataArrObj; 0)
ARRAY OBJECT:C1221($addressDataArrObj; 0)


For ($i; 1; Size of array:C274($rawObjArray))
	$usefulPersonDataObj:=New object:C1471
	$usefulPersonDataObj.firstNames:=$rawObjArray{$i}.person.firstNames
	$usefulPersonDataObj.preferredFirstName:=$rawObjArray{$i}.person.preferredFirstName
	$usefulPersonDataObj.familyName:=$rawObjArray{$i}.person.familyName
	$usefulPersonDataObj.dateOfBirth:=$rawObjArray{$i}.person.dateOfBirth
	$usefulPersonDataObj.yearOfBirth:=$rawObjArray{$i}.person.yearOfBirth
	$usefulPersonDataObj.deceased:=$rawObjArray{$i}.person.deceased
	
	JSON PARSE ARRAY:C1219(JSON Stringify:C1217($rawObjArray{$i}.person.phoneList); $phoneDataArrObj)
	OB SET ARRAY:C1227($usefulPersonDataObj; "phoneList"; $phoneDataArrObj)
	
	JSON PARSE ARRAY:C1219(JSON Stringify:C1217($rawObjArray{$i}.person.addressList); $addressDataArrObj)
	OB SET ARRAY:C1227($usefulPersonDataObj; "addressList"; $addressDataArrObj)
	
	APPEND TO ARRAY:C911($personObjArrayPtr->; $usefulPersonDataObj)
End for 
