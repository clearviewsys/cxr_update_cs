//%attributes = {}
C_OBJECT:C1216($options)
C_TEXT:C284($password; $hash1; $hash2)
$password:="testPassword"

$options:=New object:C1471("algorithm"; "bcrypt"; "cost"; "10")

$hash1:=Generate password hash:C1533($password; $options)

$hash2:=Generate password hash:C1533($password; $options)

myAlert($password+": "+Char:C90(Carriage return:K15:38)+$hash1+Char:C90(Carriage return:K15:38)+$hash2)

$options:=New object:C1471("algorithm"; "bcrypt"; "cost"; "10")

$hash1:=Generate password hash:C1533($password; $options)

$hash2:=Generate password hash:C1533($password; $options)

myAlert($password+": "+Char:C90(Carriage return:K15:38)+$hash1+Char:C90(Carriage return:K15:38)+$hash2)


