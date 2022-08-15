//%attributes = {}
C_TEXT:C284($0)
READ ONLY:C145([Currencies:6])
FIRST RECORD:C50([Currencies:6])
C_TEXT:C284($xml; $timeStamp)
C_LONGINT:C283($i)
For ($i; 1; Records in selection:C76([Currencies:6]))
	$xml:=$xml+makeXMLForCssRateRow
	NEXT RECORD:C51([Currencies:6])
End for 
$timeStamp:=enTag("TIMESTAMP"; "Rates updated on "+String:C10(Current date:C33)+" at "+String:C10(Current time:C178)+" "+<>timeZone)
$xml:=enTag("CATALOG"; CRLF+$timeStamp+CRLF+$xml)
$0:=$xml