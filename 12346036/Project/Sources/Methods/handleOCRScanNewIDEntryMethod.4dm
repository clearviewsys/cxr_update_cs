//%attributes = {}
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(documentCode; lastAdded)
		C_PICTURE:C286(docPhoto; docPhoto2)
		
		ARRAY TEXT:C222(arrTextsOCR; 0)
		ARRAY TEXT:C222(arrFieldsOCR; 0)
		ARRAY TEXT:C222(arrValuesOCR; 0)
		ARRAY TEXT:C222(arrFieldsDefinedOCR; 0)
		ARRAY LONGINT:C221(arrFieldsPositionOCR; 0)
		
		C_BOOLEAN:C305(docScanned; docModified)
		
		docScanned:=False:C215
		docModified:=False:C215
		lastAdded:=""
		docPhoto2:=docPhoto
		pOCRResult:=0
		pPayload:=0
		
		
		
		
End case 

