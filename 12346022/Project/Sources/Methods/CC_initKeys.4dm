//%attributes = {}
C_TEXT:C284($user; $pass)

$user:="blake@clearviewsys.com"
$pass:="1e43d2c9891e6f2b1e9689e6f58928e1c643c96a1961923432742199c3282346"

setKeyValue("currencyCloud.activated"; "true")
setKeyValue("currencyCloud.user"; $user)
setKeyValue("currencyCloud.pass"; $pass)

ASSERT:C1129(getKeyValue("currencyCloud.activated")="true")
ASSERT:C1129(getKeyValue("currencyCloud.user")=$user)
ASSERT:C1129(getKeyValue("currencyCloud.pass")=$pass)