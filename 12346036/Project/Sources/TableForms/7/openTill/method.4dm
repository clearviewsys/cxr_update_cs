
If (Form event code:C388=On Load:K2:1)
	fillOpeningArrays
	vMainCashRegisterID:="00"
	
	EDIT ITEM:C870(arrOpenings; 1)
	
End if 

If (Form event code:C388=On Data Change:K2:15)
	
End if 

