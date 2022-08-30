//handleFocusBorder ("focus_vAmountLocal")
applyFocusRect
If ((Form event code:C388=On Getting Focus:K2:7) & (rb5=1))
	setRadioButtonStatesInInvoice(1)
	highlightFieldPtr(Self:C308)
	
End if 
If (Form event code:C388=On Data Change:K2:15)
	GOTO OBJECT:C206(*; "vAmount")
End if 
