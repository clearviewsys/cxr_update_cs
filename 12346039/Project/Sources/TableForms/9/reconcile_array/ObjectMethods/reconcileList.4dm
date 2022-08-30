If (Form event code:C388=On Load:K2:1)
	C_BOOLEAN:C305(recon_isTouched)
	recon_isTouched:=False:C215
	//recon_handleReconciliationListB 
	//EDIT ITEM(arrValidation;1)
	
End if 

If ((Form event code:C388=On After Sort:K2:28) | (Form event code:C388=On Row Moved:K2:32))
	fillRunningBalanceArray(->arrDebits; ->arrCredits; ->arrBalances; vSumOpeningBalance)
End if 


If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	recon_isTouched:=True:C214
End if 

