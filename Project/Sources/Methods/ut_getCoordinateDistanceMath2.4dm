//%attributes = {"shared":true}
//author: Amir
//2nd April 2020
//test method for Address_GetDistanceMath
//AJAR @Zoya
//13 Jan 2021
// __UNIT_TEST

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("getCoordinateDistanceMath2"; Current method name:C684; "Math.Geolocation")

C_OBJECT:C1216($pointA; $pointB)
C_REAL:C285($distance)
$pointA:=New object:C1471
$pointA.lat:=49.3157976
$pointA.lng:=-123.0745078

$pointB:=$pointA
$distance:=getCoordinateDistanceMath2($pointA; $pointB)
AJ_assert($test; $distance; 0; JSON Stringify:C1217($pointA)+JSON Stringify:C1217($pointB); "Expected zero for distance of point to itself")
//ASSERT($distance=0;"Expected zero for distance of point to itself")

$pointB:=New object:C1471
$pointB.lat:=49.3285962
$pointB.lng:=-123.1648352
C_REAL:C285($distance2)
$distance:=getCoordinateDistanceMath2($pointA; $pointB)
$distance2:=getCoordinateDistanceMath2($pointB; $pointA)
AJ_assert($test; $distance; $distance2; "distance is from A to B, compared to distnace2 whichis from B to A"; "Expected same distance")
//ASSERT($distance=$distance2;"Expected same distance")
//ASSERT(($distance>6699) & ($distance<6700);"Expectation failed for distance")

AJ_assert($test; ($distance>6699) & ($distance<6700); True:C214; "distance =6699.589602742 , the condition to check ($distance>6699) & ($distance<6700) "; "Expectation failed for distance")

