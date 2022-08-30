//%attributes = {}
C_TEXT:C284($test)
$test:="{\"persons\":[{\"memento\":\"eyJzb3VyY2VEYXRhYmFzZSI6ImNpYS1lbGFzdGljc2VhcmNoIiwidGltZXN0YW1wIjoxNTY5OTA0NzY5NjE3LCJnZW5lcmF0aW9uS2V5IjoiIiwicGVyc29uS2V5IjoiQTJBRTNaODQ2TjdBIn0=\",\"person\":{\"gedi\":\"A2AE3Z846N7A\",\"protectedIdentity\":false,\"firstNames\":[\"Sven"+"\",\"Henning\"],\"preferredFirstName\":\"Sven\",\"familyName\":\"Svensson\",\"dateOfBirth\":\"1949-09-06\",\"yearOfBirth\":1949,\"deceased\":false,\"phoneList\":[{\"type\":\"Mobile\",\"number\":\"+46703520422\",\"telemarketingRestriction\":true}],\"addressList\":[{\"type\":\"Visiting\",\""+"subType\":\"Domicile\",\"streetName\":\"Vasagatan\",\"streetNumber\":\"5\",\"entrance\":\"B\",\"apartment\":\"1202\",\"postalCode\":\"79530\",\"city\":\"Rättvik\",\"country\":\"SE\",\"formattedAddress\":[\"Vasagatan 5 B lgh 1202\",\"79530 Rättvik\"]}]},\"subscriptionState\":{\"subscribed\""+":false}}]}"
ARRAY OBJECT:C1221($personArray; 0)

BisN_deserializePersonResponse("{\"persons\":[]}"; ->$personArray)
ASSERT:C1129(Size of array:C274($personArray)=0; "Error: expected empty array")
BisN_deserializePersonResponse($test; ->$personArray)
ASSERT:C1129(Size of array:C274($personArray)=1; "Error: expected array to have one object")
ASSERT:C1129(Not:C34($personArray{1}.firstNames=Null:C1517); "Error: expected firstNames property for person object")
ASSERT:C1129(Not:C34($personArray{1}.preferredFirstName=Null:C1517); "Error: expected preferredFirstName property for person object")
ASSERT:C1129(Not:C34($personArray{1}.familyName=Null:C1517); "Error: expected familyName property for person object")
ASSERT:C1129(Not:C34($personArray{1}.dateOfBirth=Null:C1517); "Error: expected dateOfBirth property for person object")
ASSERT:C1129(Not:C34($personArray{1}.yearOfBirth=Null:C1517); "Error: expected yearOfBirth property for person object")
ASSERT:C1129(Not:C34($personArray{1}.deceased=Null:C1517); "Error: expected deceased property for person object")
ASSERT:C1129(Not:C34($personArray{1}.phoneList=Null:C1517); "Error: expected phoneList property for person object")
ASSERT:C1129(Not:C34($personArray{1}.addressList=Null:C1517); "Error: expected addressList property for person object")

ARRAY OBJECT:C1221($result; 0)
OB GET ARRAY:C1229($personArray{1}; "phoneList"; $result)
ASSERT:C1129(String:C10($result{1}.type)="Mobile"; "Error: expected \"Mobile\" as the type of phone")
ASSERT:C1129(String:C10($result{1}.number)="+46703520422"; "Error: expected \"+46703520422\" as the number")

ARRAY OBJECT:C1221($result; 0)
OB GET ARRAY:C1229($personArray{1}; "addressList"; $result)
ASSERT:C1129(String:C10($result{1}.type)="Visiting"; "Error: expected \"Visiting\" as the type of address")
