C_LONGINT:C283(rb1; rb2; rb3; rb4; rb)
C_REAL:C285(vInverseRate; vAmountBeforeFees; vPercentFeeLocal)
Case of 
	: (Form event code:C388=On Load:K2:1)
		UNLOAD RECORD:C212([eWires:13])  //make user pick
		UNLOAD RECORD:C212([Links:17])
		vEwireID:=""
		rb5:=1  // calculate the amount Local
		vInverseRate:=0
		vAmountBeforeFees:=0
		
		
		If (getKeyValue("ëwire.autosettle"; "true")="true")
			vbIsSettled:=True:C214
		End if 
End case 
C_REAL:C285($sellRate)


If ([eWires:13]FromAmount:13>0)
	C_LONGINT:C283($switch)
	Case of 
		: (rb1=1)  //vAmount
			$switch:=1
		: (rb2=1)  // vRate
			$switch:=2
		: (rb3=1)  //vPercentFee
			$switch:=3
		: (rb4=1)  // vFeeLocal
			$switch:=4
		: (rb5=1)  // vAmountLocal
			$switch:=5
	End case 
	handleCalculationFields($switch; False:C215; [eWires:13]Currency:12; ->[eWires:13]FromAmount:13; ->[eWires:13]destinationRate:87; ->[eWires:13]destinationPctFee:90; ->[eWires:13]DestinationServiceFee:21; ->[eWires:13]destinationAmountLocal:88)
	REDRAW WINDOW:C456
End if 

C_REAL:C285(vAmount; vTotalFeesLocal)
vAmountBeforeFees:=calcvAmountLocal_BF([eWires:13]FromAmount:13; [eWires:13]destinationRate:87)
calcFeesInInvoice(vAmountBeforeFees; [eWires:13]destinationPctFee:90; [eWires:13]DestinationServiceFee:21; ->vPercentFeeLocal; ->vTotalFeesLocal)
//normalizeVarsInInvoice 

