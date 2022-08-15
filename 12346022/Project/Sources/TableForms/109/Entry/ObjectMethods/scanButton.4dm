C_TEXT:C284($msg)

If (docScanned)
	
	// If you scan the ID again, you have to add all the fields from scratch. Are you sure?
	$msg:=GetLocalizedErrorMessage(4224)
	CONFIRM:C162($msg; getLocalizedKeyword("yes"); getLocalizedKeyword("no"))
	
	If (ok=1)
		
		CLEAR VARIABLE:C89(arrPayload)
		CLEAR VARIABLE:C89(arrOCRResult)
		CLEAR VARIABLE:C89(fieldsObject)
		CLEAR VARIABLE:C89(arrUsedFields)
		C_OBJECT:C1216(fieldsObject)
		OCR_ScanPicture(->arrOCRResult; ->[OCR_Ids:109]Photo:4; lang; True:C214)
		OCR_CleanScannedText(->arrOCRResult)
		docScanned:=True:C214
	Else 
		// Do nothing
	End if 
	
Else 
	
	CLEAR VARIABLE:C89(arrPayload)
	CLEAR VARIABLE:C89(arrOCRResult)
	CLEAR VARIABLE:C89(fieldsObject)
	C_OBJECT:C1216(fieldsObject)
	
	OCR_ScanPicture(->arrOCRResult; ->[OCR_Ids:109]Photo:4; lang; True:C214)
	OCR_CleanScannedText(->arrOCRResult)
	docScanned:=True:C214
End if 
