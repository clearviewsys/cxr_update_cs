//%attributes = {}
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		initOCRArrays
		XLIFF_TranslateFormObjects
		OCR_SetOCR_IdsFields
		
	: (Form event code:C388=On Clicked:K2:4)
		
		handleSizeOfImageVar(->vSizeOfImage; ->docPhoto2; "vSizeOfImage")
End case 

