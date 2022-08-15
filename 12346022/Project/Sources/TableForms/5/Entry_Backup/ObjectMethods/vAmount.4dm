If (Form event code:C388=On After Keystroke:K2:26)
	C_REAL:C285(vReflection)
	vReflection:=Num:C11(Get edited text:C655)
	REDRAW:C174(vReflection)
	
	If (VRECEIVEDORPAID="")  // we don't want the user to enter an amount if it's not known if transaction is buy/sell
		BEEP:C151
		GOTO OBJECT:C206(VRECEIVEDORPAID)
		VAMOUNT:=0
		REDRAW:C174(VAMOUNT)
	End if 
End if 

showObjectOnTrue((Form event code:C388=On Getting Focus:K2:7); "vReflection")
hideObjectsOnTrue((Form event code:C388=On Losing Focus:K2:8); "vReflection")
applyFocusRect

If ((Form event code:C388=On Getting Focus:K2:7) & (rb1=1))
	setRadioButtonStatesInInvoice(5)
	highlightFieldPtr(Self:C308)
End if 
