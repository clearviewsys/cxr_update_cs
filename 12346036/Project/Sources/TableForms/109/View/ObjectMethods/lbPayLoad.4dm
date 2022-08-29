Case of 
		
	: ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Selection Change:K2:29))
		
		C_LONGINT:C283(pPayload)
		C_POINTER:C301($objPtr)
		$objPtr:=Focus object:C278
		pPayload:=$objPtr->
		
	: (Form event code:C388=On Load:K2:1)
		OCR_SetListboxRowHeight(->arrPayLoad; ->lbPayLoad)
		
End case 
