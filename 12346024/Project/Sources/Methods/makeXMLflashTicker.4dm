//%attributes = {}
C_TEXT:C284($0)

FIRST RECORD:C50([Currencies:6])
C_TEXT:C284($xml)
C_LONGINT:C283($i)
For ($i; 1; Records in selection:C76([Currencies:6]))
	$xml:=$xml+makeXMLRowFlashTicker
	NEXT RECORD:C51([Currencies:6])
End for 

$xml:=enTag("ticker"; $xml)
$0:=$xml