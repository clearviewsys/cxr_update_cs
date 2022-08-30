If (Form event code:C388=On Display Detail:K2:22)
	C_REAL:C285(vTotalFees)
	vTotalFees:=Abs:C99([Registers:10]Debit:8-[Registers:10]Credit:7)*[Registers:10]OurRate:25*[Registers:10]percentFee:28/100+[Registers:10]feeLocal:29
	colourizeLineBG("backstripe")
End if 