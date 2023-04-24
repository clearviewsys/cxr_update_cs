

applyFocusRect
If (Form event code:C388=On Clicked:K2:4)
	
	setReceivedOrPaid(1)
	setVecCurrency(<>defaultBuyCurrency)
	handleVecPaymentPullDown(->vecPaymentMethod; 1)
	setVecCurrency(vecCurrency{vecCurrency}; True:C214)
	GOTO OBJECT:C206(vAmount)
End if 
