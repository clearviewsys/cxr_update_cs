If (Form event code:C388=On Clicked:K2:4)
	C_REAL:C285(vAmount; vCustomerBalanceDue)
	vAmount:=Abs:C99(vCustomerBalanceDue)
End if 