//%attributes = {}
// OCR_DeleteField 
// Delete a field from the payload after scanning an ID
// TODO: Fix Objects


C_LONGINT:C283($p)

Case of 
	: (Count parameters:C259=0)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 



If (arrPayload>0)
	// Delete Entry from payload Array
	
	
	$p:=Find in array:C230(arrUsedFields; selectedFieldCode{arrPayload})
	If ($p>0)
		DELETE FROM ARRAY:C228(arrUsedFields; $p; 1)
	End if 
	
	DELETE FROM ARRAY:C228(selectedFieldCode; arrPayload; 1)
	DELETE FROM ARRAY:C228(selectedFieldName; arrPayload; 1)
	DELETE FROM ARRAY:C228(selectedExample; arrPayload; 1)
	DELETE FROM ARRAY:C228(selectedOCRPos; arrPayload; 1)
	DELETE FROM ARRAY:C228(selectedRegExp; arrPayload; 1)
	DELETE FROM ARRAY:C228(arrPayload; pPayload; 1)
	OCR_updatePayLoad
	
Else 
	
	myAlert(GetLocalizedErrorMessage(4225))  // Before deleting, you must select a field.
	
End if 

docModified:=True:C214
lastAdded:=""
