Case of 
		
	: ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Selection Change:K2:29))
		
		C_LONGINT:C283(pOCRResult)
		C_POINTER:C301($objPtr)
		$objPtr:=Focus object:C278
		pOCRResult:=$objPtr->
		
		
End case 
