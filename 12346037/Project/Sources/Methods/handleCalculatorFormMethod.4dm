//%attributes = {}
C_REAL:C285(vFromMarketAvg; vFromOurBuy; vToOurSell; vExchangeRateAvg; vOurExchangeRate; vToMarketAvg; vInverseRate; vServiceFee)
C_REAL:C285(vFromAmount; vExchangeRate; vServiceFee; vToAmount)
C_LONGINT:C283(cbFeePaidSeparately; rbFromAmount; rbExchangeRate; rbServiceFee; rbToAmount)
C_REAL:C285(vRate1; vRate2)

If (vToMarketAvg#0)
	vExchangeRateAvg:=Round:C94(vFromMarketAvg/vToMarketAvg; 7)
	If ((vFromMarketAvg#1) & (vToMarketAvg#1))  // cross
		C_REAL:C285($vRate1; $vRate2)
		Case of   //COMMISSION LEG POLICIES********************************
			: (<>ChargeLeg=0)  // none
				$vRate1:=vFromMarketAvg
				$vRate2:=vToMarketAvg
			: (<>ChargeLeg=1)  // commission on buy
				$vRate1:=vFromOurBuy
				$vRate2:=vToMarketAvg
			: (<>ChargeLeg=2)  // commission on sell
				$vRate1:=vFromMarketAvg
				$vRate2:=vToOurSell
			: (<>ChargeLeg=3)  // commission on both
				$vRate1:=vFromOurBuy
				$vRate2:=vToOurSell
		End case 
		
		vRate1:=$vRate1
		vRate2:=$vRate2
		vOurExchangeRate:=vRate1/vRate2
		
	Else 
		vOurExchangeRate:=vFromOurBuy/vToOurSell  // this is where
	End if 
Else 
	vExchangeRateAvg:=0
	vOurExchangeRate:=0
End if 

roundUp(->vOurExchangeRate)

If (vExchangeRate#0)
	vInverseRate:=Round:C94(1/vExchangeRate; 7)
Else 
	vInverseRate:=0
End if 

calcCalculatorVars


C_REAL:C285(vForeignFeeInCAD; vCommissionInCAD; vExchangeDiffInCAD; vTotalFeesInCAD)
vForeignFeeInCAD:=vForeignFee*(vExchangeRate*vRate2)
vCommissionInCAD:=(vFromAmount-vForeignFee)*(vExchangeRate*vRate2)*(vPercentFee/100)
vTotalFeesInCAD:=vForeignFeeInCAD+vCommissionInCAD+vServiceFee
vExchangeDiffInCAD:=(vFromAmount*vFromMarketAvg)-(vToAmount*vToMarketAvg)