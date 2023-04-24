//%attributes = {}
C_TEXT:C284($email; $api_key; $auth_key; $error)
C_POINTER:C301($pError)

$email:="blake@clearviewsys.com"  //"moneyway.apiuser"  //"blake@clearviewsys.com"
$api_key:="1e43d2c9891e6f2b1e9689e6f58928e1c643c96a1961923432742199c3282346"  //"4d63886dea01fb8ae99547ef894c9c6bebc6892c556c43b0d9a410a3489cba89"  //"1e43d2c9891e6f2b1e9689e6f58928e1c643c96a1961923432742199c3282346"
$error:=""
$pError:=->$error

$auth_key:=CC_login($email; $api_key; $pError)

If (Length:C16($auth_key)<=3)
	ALERT:C41("Error: "+$auth_key+": "+$error)
Else 
	ALERT:C41("Auth key is: "+$auth_key)
End if 