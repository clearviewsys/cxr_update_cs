[AccountInOuts:37]ourRate:13:=Round:C94(calcSafeDivide(1; vInverseRate); [Currencies:6]RoundDigit:27)
If (Form event code:C388=On Data Change:K2:15)
	POST OUTSIDE CALL:C329(Current process:C322)
End if 