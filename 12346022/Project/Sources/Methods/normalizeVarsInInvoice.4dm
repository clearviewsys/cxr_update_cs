//%attributes = {}
// this method rounds all local currency variable to 2 digits (or whatever the local currency rounds to)

vAmountLocal:=roundToBase(vAmountLocal)
vAmountLocal_BF:=roundToBase(vAmountLocal_BF)

If (Records in selection:C76([Currencies:6])=1)
	vAmount:=Round:C94(vAmount; [Currencies:6]RoundLowestDenom:13)
Else 
	vAmount:=Round:C94(vAmount; <>roundDigitBaseCurrency)
End if 

vTotalFeesLocal:=roundToBase(vTotalFeesLocal)