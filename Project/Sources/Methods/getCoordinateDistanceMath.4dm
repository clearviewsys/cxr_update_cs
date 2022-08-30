//%attributes = {}
//author: Amir
//2nd April 2020
//This method should not be used directly. 
//It is intended for Address_GetDistanceMath or databse SQL querries for address proximity search
//it calculates distance between two latitude longitude points 
//answer from https://stackoverflow.com/questions/27928/calculate-distance-between-two-latitude-longitude-points-haversine-formula

C_REAL:C285($1; $2; $3; $4)
C_REAL:C285($lat1; $lng1; $lat2; $lng2)
$lat1:=$1
$lng1:=$2
$lat2:=$3
$lng2:=$4
C_REAL:C285($0; $distance)

C_REAL:C285($degreeToRadian; $earthRadiusInMeter; $deltaLat; $deltaLng; $a; $c; $d)
$earthRadiusInMeter:=6371000
$degreeToRadian:=0.01745329251994  // PI/180
$deltaLat:=$degreeToRadian*($lat2-$lat1)
$deltaLng:=$degreeToRadian*($lng2-$lng1)
$a:=(Sin:C17($deltaLat/2)*Sin:C17($deltaLat/2))+(Cos:C18($degreeToRadian*$lat1)*Cos:C18($degreeToRadian*$lat2)*Sin:C17($deltaLng/2)*Sin:C17($deltaLng/2))
$c:=2*Arctan:C20((Square root:C539($a))/(Square root:C539(1-$a)))
$distance:=$earthRadiusInMeter*$c

$0:=$distance