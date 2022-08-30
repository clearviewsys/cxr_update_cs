//%attributes = {}
C_TEXT:C284($code)
C_LONGINT:C283($i)
$code:="CA"
// [countries];"pick"
For ($i; 1; 3)
	pickCountryCode(->$code)
	myAlert($code+CRLF+[Countries:62]CountryName:2)
	$code:=""
End for 