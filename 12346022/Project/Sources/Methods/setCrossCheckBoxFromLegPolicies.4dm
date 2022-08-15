//%attributes = {}
C_LONGINT:C283(cbChangeBuyRate; cbChangeSellRate)

Case of   //COMMISSION LEG POLICIES********************************
	: (<>ChargeLeg=0)  // none
		cbChangeBuyRate:=0
		cbChangeSellRate:=0
	: (<>ChargeLeg=1)  // commission on buy
		cbChangeBuyRate:=1
		cbChangeSellRate:=0
		
	: (<>ChargeLeg=2)  // commission on sell
		cbChangeBuyRate:=0
		cbChangeSellRate:=1
		
	: (<>ChargeLeg=3)  // commission on both
		cbChangeBuyRate:=1
		cbChangeSellRate:=1
		
End case 