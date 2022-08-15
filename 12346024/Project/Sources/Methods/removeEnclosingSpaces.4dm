//%attributes = {}
//removeEnclosingSpaces (string) : string
// removes all leading and trailing spaces and returns the string

C_TEXT:C284($1; $string; $0)
If (Count parameters:C259=0)
	$string:="    tiran  "
Else 
	$string:=$1
End if 

$string:=removeLeadingChars($string)
$string:=removeTrailingChars($string)
$string:=removeMiddleExtraSpace($string)

$0:=$String
