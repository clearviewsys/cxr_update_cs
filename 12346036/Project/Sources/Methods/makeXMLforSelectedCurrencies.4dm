//%attributes = {}
C_TEXT:C284($0)
C_LONGINT:C283($i)

FIRST RECORD:C50([Currencies:6])
C_TEXT:C284($xml)
For ($i; 1; Records in selection:C76([Currencies:6]))
	$xml:=$xml+makeXMLforCurrency
	NEXT RECORD:C51([Currencies:6])
End for 

$xml:=enTag("dataSet"; $xml)
$0:=$xml