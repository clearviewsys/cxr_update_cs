//%attributes = {}
// handlePayOffButton

//If (Form event=On Clicked )

If ((vDueToCustomer=0) & (vDueFromCustomer=0))
	//ALERT("Nothing left to pay off")
	BEEP:C151
Else   // there is off balance to pay off
	
	If (getVecCurrencyString="")
		setVecCurrency(<>baseCurrency)
	Else 
		handleVecCurrencyMethod
	End if 
	
	If (vecPaymentMethod{0}="")
		vecPaymentMethod{0}:=c_Cash
	End if 
	
	//vPercentFee:=0
	//vPercentFeeLocal:=0
	//vFeeLocal:=0
	If (vDueToCustomer>0)
		setReceivedOrPaid(2)  // paid
		vAmountLocal:=vDueToCustomer
	Else 
		setReceivedOrPaid(1)  // received
		
		If (vecPaymentMethod{vecPaymentMethod}=c_Cash)
			//vAmountLocal:=Num(myRequest ("Pease enter the amount received in cash?";String(vDueFromCustomer)))
			vAmountLocal:=displayReceiveCashLCForm(vDueFromCustomer)
		Else 
			vAmountLocal:=vDueFromCustomer
		End if 
		
	End if 
	setRadioButtonStatesInInvoice(1)
	handleInvoiceCalculations
	
	// TB: added the following lines on March 20, 2009
	setRadioButtonStatesInInvoice(5)
	GOTO OBJECT:C206(vAmount)
	//calcvAmount   ` calculate vAmount based on the vAmountLocal
	
End if 

//End if   ` end if on clicked
