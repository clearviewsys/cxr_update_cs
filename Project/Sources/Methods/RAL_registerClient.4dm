//%attributes = {}
C_TEXT:C284($user; $password)
C_TEXT:C284($firstName; $lastName; $isCompany; $companyName; $email; $phone)
C_TEXT:C284($address; $city; $province; $country; $postalCode)
C_TEXT:C284($returnString)
C_LONGINT:C283($returnCode)


$user:=<>WSUSER
$password:=<>WSPASSWORD
$returnString:=""
$returnCode:=0

$firstName:="Tiran"
$lastName:="Behrouz"
$isCompany:="true"
$companyName:="Clear View Systems Ltd. Test"
$email:="tb@clearviewsys.com"
$phone:="6049131660"
$address:="1113-2012 Fullerton Ave."
$city:="North Van"
$province:="BC"
$country:="Canada"
$postalCode:="V7P 3E3"

ws_RAL_registerClient($user; $password; $firstName; $lastName; $isCompany; $companyName; $email; $phone; $address; $city; $province; $country; $postalCode; ->$returnString; ->$returnCode)

myAlert($returnString+String:C10($returnCode))
