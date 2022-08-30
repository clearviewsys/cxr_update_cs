
Case of 
		
		
	: (Form event code:C388=On Load:K2:1)
		
		
		C_LONGINT:C283($p)
		ARRAY TEXT:C222(arrDocCode; 0)
		ARRAY TEXT:C222(arrDocName; 0)
		
		OCR_GetIDList(->arrDocCode; ->arrDocName)
		arrDocCode:=1
		arrDocName:=1
End case 
