C_TEXT:C284($w1; $w2; $w3)
C_BOOLEAN:C305($set)

$w1:="col_countries"
$w2:="col_currencyNames"
$w3:="col_hidden"

If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	$set:=(Self:C308->=1)
	
	OBJECT SET ENTERABLE:C238(*; $w1; $set)
	OBJECT SET ENTERABLE:C238(*; $w2; $set)
	OBJECT SET ENTERABLE:C238(*; $w3; $set)
	
End if 