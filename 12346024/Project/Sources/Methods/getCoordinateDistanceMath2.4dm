//%attributes = {}
//author: Amir
//30th March 2020
//mathematically calculate straight line distance between two coordinates(lat;lng)
//answer from https://stackoverflow.com/questions/27928/calculate-distance-between-two-latitude-longitude-points-haversine-formula
//distance<C_REAL>:=Address_GetDistanceMath(objectA<C_OBJECT>;
//                                                objectB<C_OBJECT>)
//objectA and objectB should have properties lat, lng in degrees

// Unit test is written @Zoya

C_OBJECT:C1216($1; $pointA)
C_OBJECT:C1216($2; $pointB)
C_REAL:C285($0; $distance)

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

$distance:=getCoordinateDistanceMath($pointA.lat; $pointA.lng; $pointB.lat; $pointB.lng)

$0:=$distance