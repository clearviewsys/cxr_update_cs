//%attributes = {}
C_BOOLEAN:C305($0)
C_TEXT:C284($1; $curr)

$curr:=$1

If (($curr="USD") | ($curr="EUR") | ($curr="CAD") | ($curr="JPY") | ($curr="CNY") | ($curr="CHF") | ($curr="GBP") | ($curr="AUD") | ($curr="HKD"))
	$0:=True:C214
Else 
	$0:=False:C215
End if 