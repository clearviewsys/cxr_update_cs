Case of 
	: (Form event code:C388=On Load:K2:1)
		
		Self:C308->:=SIGPAD_Get_stroke_width("Signature")
		
	: (Form event code:C388=On Data Change:K2:15)
		
		SIGPAD_SET_STROKE_WIDTH("Signature"; Self:C308->)
		
End case 