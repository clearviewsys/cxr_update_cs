//%attributes = {}
// OCR_AddField
// Add a new field to the OCR Payload after scanning an ID
// TODO: Fix Objects

C_LONGINT:C283($p)
C_TEXT:C284($obj)
C_TEXT:C284($arrPayLoadText)
ARRAY TEXT:C222($arrObj; 0)


Case of 
	: (Count parameters:C259=0)
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ((arrFieldName>0) & (pOCRResult>0))
	
	$arrPayLoadText:=arrFieldName{arrFieldName}+CRLF+"(i.e: "+arrOCRResult{pOCRResult}+")"
	
	$p:=Find in array:C230(arrUsedFields; arrFieldCode{arrFieldName})
	If ($p<0)
		OCR_AddToPayload($arrPayLoadText)
	Else 
		myAlert(GetLocalizedErrorMessage(4226))  // Field has been selected previously
	End if 
Else 
	myAlert(GetLocalizedErrorMessage(4227))  // before adding a field, you must select a scanned element
End if 
