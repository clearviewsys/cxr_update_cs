//%attributes = {}
C_TEXT:C284($password; $output)
C_BLOB:C604($encrypted)
C_OBJECT:C1216($pattern)
$password:="TestPassword"
$pattern:=New object:C1471("password"; $password; "privateKey"; "TestKey")

$encrypted:=UTIL_Encrypt($password; $pattern)

$output:=UTIL_Decrypt($encrypted; $pattern)