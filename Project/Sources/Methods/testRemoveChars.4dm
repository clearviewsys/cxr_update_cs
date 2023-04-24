//%attributes = {}
C_TEXT:C284($str)

$str:=removeChars("Tiran"; "r")
ASSERT:C1129($str="tian")

$str:=removeChars("Tirrrrran"; "r")
ASSERT:C1129($str="tian")

$str:=removeChars("Tiran"; "ran")
ASSERT:C1129($str="ti")

$str:=removeChars("Tirannn"; "rn")
ASSERT:C1129($str="tia")
