//%attributes = {}


C_TEXT:C284($user; $password)
C_TEXT:C284($email)
C_TEXT:C284($returnString)
C_LONGINT:C283($returnCode)

$user:=<>WSUSER
$password:=<>WSPASSWORD
$returnString:=""
$returnCode:=0

$email:="tb@clearviewsys.com"

ws_RAL_findAndEmailClientCode($user; $password; $email; ->$returnString; ->$returnCode)

myAlert($returnString+String:C10($returnCode))

