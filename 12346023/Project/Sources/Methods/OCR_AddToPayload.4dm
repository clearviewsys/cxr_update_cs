//%attributes = {}
// OCR_AddToPayload 
// Add a new field to payload after scanning an ID
// TODO: Fix Objects


C_TEXT:C284($1; $arrPayLoadText)

C_OBJECT:C1216($fieldObj; $regExpObj)

ARRAY TEXT:C222($arrFieldsObj; 0)
ARRAY TEXT:C222($arrRegExpObj; 0)
ARRAY TEXT:C222($arrRegExp; 0)
C_BOOLEAN:C305($match)
C_TEXT:C284($msg)


Case of 
	: (Count parameters:C259=1)
		$arrPayLoadText:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$match:=Match regex:C1019(arrFieldRegExp{arrFieldName}; arrOCRResult{pOCRResult})

If ($match)
	
	APPEND TO ARRAY:C911(arrPayload; $arrPayLoadText)
	
	APPEND TO ARRAY:C911(selectedFieldCode; arrFieldCode{arrFieldName})
	APPEND TO ARRAY:C911(selectedFieldName; arrFieldName{arrFieldName})
	APPEND TO ARRAY:C911(selectedExample; arrOCRResult{pOCRResult})
	
	APPEND TO ARRAY:C911(selectedOCRPos; arrOCRResult)
	APPEND TO ARRAY:C911(selectedRegExp; arrFieldRegExp{arrFieldName})
	APPEND TO ARRAY:C911(selectedPayloadPos; pOCRResult)
	APPEND TO ARRAY:C911(arrUsedFields; arrFieldCode{arrFieldName})
	
	
	lastAdded:=arrFieldName{arrFieldName}
	docModified:=True:C214
	arrFieldID:=0
	arrFieldName:=0
	arrFieldName{0}:="-- "+Uppercase:C13(getLocalizedKeyword("select"))+" --"
	arrFieldCode:=0
	arrFieldName:=0
	arrFieldRegExp:=0
	OCR_updatePayLoad
	
Else 
	$msg:=arrOCRResult{pOCRResult}+"\nIs not a field of type: "+Uppercase:C13(arrFieldName{arrFieldName})
	myAlert($msg)
End if 

