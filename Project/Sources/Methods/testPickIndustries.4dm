//%attributes = {}
C_TEXT:C284($industryCode)
C_LONGINT:C283($i)
// Form: ([Industries];"Pick")
$industryCode:="9000"
For ($i; 1; 2)
	pickIndustryCode(->$industryCode)
	myAlert($industryCode+CRLF+[Industries:114]Industry:2)
	$industryCode:=""
End for 
