If (Form event code:C388=On Printing Detail:K2:18)
	setVisibleIff(([ItemInOuts:40]discount:33>0); "l_discount")
	setVisibleIff(([ItemInOuts:40]discount:33>0); "discount")
	
End if 

