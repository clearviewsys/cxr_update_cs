Case of 
	: (Form event code:C388=On Load:K2:1)
		
		Self:C308->:=SIGPAD_Get_stroke_opacity("Signature")*100
		
	: (Form event code:C388=On Data Change:K2:15)
		
		SIGPAD_SET_STROKE_OPACITY("Signature"; Self:C308->/100)
		
End case 