
Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		//TRACE
		handledoubleclickevent(->[Registers:10])
		//displayRecord (->[Registers];Record number([Registers]))s
		
		
	: (Form event code:C388=On Display Detail:K2:22)
		C_REAL:C285(vTotalFees; vInvRate)
		vTotalFees:=Abs:C99([Registers:10]Debit:8-[Registers:10]Credit:7)*[Registers:10]OurRate:25*[Registers:10]percentFee:28/100+[Registers:10]feeLocal:29
		vInvRate:=calcSafeDivide(1; [Registers:10]OurRate:25)
		//showObjectOnTrue ([Registers]isAML_Reportable;[Registers]AML_mustReportBefore)
		colourizeLineBG("backstripe")
End case 