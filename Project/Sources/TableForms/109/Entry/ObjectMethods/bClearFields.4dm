Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		CLEAR VARIABLE:C89(arrPayload)
		CLEAR VARIABLE:C89(fieldsObject)
		CLEAR VARIABLE:C89(arrUsedFields)
		C_OBJECT:C1216(fieldsObject)
		
		initOCRArrays
		[OCR_Ids:109]OCRPayLoad:6:=New object:C1471
		[OCR_Ids:109]OCRResult:5:=New object:C1471
		
		
End case 

