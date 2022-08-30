//%attributes = {}
C_LONGINT:C283($ind)
If (False:C215)
	ARRAY TEXT:C222(vecPaymentMethod; 0)
End if 

//handleFocusBorder ("focus_vRecPaid")
C_TEXT:C284($Keystroke)
Case of 
	: (Form event code:C388=On Before Keystroke:K2:6)
		$Keystroke:=Keystroke:C390
		
		Case of   // Check to see if a "function" key is hit
			: (($Keystroke="D") | ($keystroke="R"))  // REceived/Buy
				setReceivedOrPaid(1)
				setVecCurrency(<>baseCurrency)
				$ind:=Find in array:C230(vecPaymentMethod; <>defaultBuyMethod)
				
			: (($Keystroke="C") | ($keystroke="P"))  // Paid/Sell
				setReceivedOrPaid(2)
				setVecCurrency(<>baseCurrency)
				$ind:=Find in array:C230(vecPaymentMethod; <>defaultSellMethod)
				
			: ($Keystroke="B")  // Buy
				setReceivedOrPaid(1)
				setVecCurrency(<>defaultBuyCurrency)
				$ind:=Find in array:C230(vecPaymentMethod; <>defaultBuyMethod)
				
			: ($Keystroke="S")  // Sell
				setReceivedOrPaid(2)
				setVecCurrency(<>defaultSellCurrency)
				$ind:=Find in array:C230(vecPaymentMethod; <>defaultSellMethod)
				
		End case 
		handleVecPaymentPullDown(->vecPaymentMethod; $ind)
		
		FILTER KEYSTROKE:C389("")
		//GOTO AREA(*;"vAmount")
		If (VRECEIVEDORPAID#"")
			POST KEY:C465(Tab key:K12:28)
			setVecCurrency(vecCurrency{vecCurrency}; True:C214)
		Else 
			GOTO OBJECT:C206(VRECEIVEDORPAID)
			
		End if 
	: (Form event code:C388=On Losing Focus:K2:8)
		If (VRECEIVEDORPAID="")
			GOTO OBJECT:C206(VRECEIVEDORPAID)
		End if 
		
	: (Form event code:C388=On Load:K2:1)
		//setReceivedOrPaid (1)
End case 



