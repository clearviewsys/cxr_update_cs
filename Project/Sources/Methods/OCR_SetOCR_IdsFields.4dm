//%attributes = {}

ARRAY TEXT:C222(arrOCRResult; 0)
ARRAY TEXT:C222(arrUsedFields; 0)

ARRAY TEXT:C222(arrPayload; 0)
C_PICTURE:C286(docPhoto2)


C_LONGINT:C283($i)


C_OBJECT:C1216(fieldsObject)
C_OBJECT:C1216($idOCRPayloadObj)

ARRAY OBJECT:C1221($arrOCRPayloadObj; 0)

C_OBJECT:C1216($payloadObj)
C_OBJECT:C1216($idOCRResultObj)

C_TEXT:C284($fieldCode; $tmp; $tmp1)

docScanned:=False:C215
docModified:=False:C215
lastAdded:=""
pOCRResult:=0
pPayload:=0

OCR_GetAllFields

If (Not:C34(OB Is empty:C1297([OCR_Ids:109]OCRResult:5)))
	OB GET ARRAY:C1229([OCR_Ids:109]OCRResult:5; "arrFields"; arrOCRResult)
	docPhoto2:=[OCR_Ids:109]Photo:4
End if 

If (Not:C34(OB Is empty:C1297([OCR_Ids:109]OCRPayLoad:6)))
	OB GET ARRAY:C1229([OCR_Ids:109]OCRPayLoad:6; "arrFields"; $arrOCRPayloadObj)
	
	CLEAR VARIABLE:C89(arrPayload)
	
	For ($i; 1; Size of array:C274($arrOCRPayloadObj))
		
		$fieldCode:=OB Get:C1224($arrOCRPayloadObj{$i}; "fieldCode")
		APPEND TO ARRAY:C911(arrUsedFields; $fieldCode)
		
		QUERY:C277([OCR_Fields:108]; [OCR_Fields:108]FieldCode:2=$fieldCode)
		$tmp:=OCR_SplitAndLocalizeFieldName([OCR_Fields:108]Keyword:4)
		$tmp1:=OB Get:C1224($arrOCRPayloadObj{$i}; "example")
		$tmp:=$tmp+CRLF+"(i.e: "+$tmp1+")"
		APPEND TO ARRAY:C911(arrPayload; $tmp)
		
		APPEND TO ARRAY:C911(selectedFieldCode; $fieldCode)
		APPEND TO ARRAY:C911(selectedFieldName; OB Get:C1224($arrOCRPayloadObj{$i}; "fieldName"))
		APPEND TO ARRAY:C911(selectedExample; OB Get:C1224($arrOCRPayloadObj{$i}; "example"))
		APPEND TO ARRAY:C911(selectedOCRPos; OB Get:C1224($arrOCRPayloadObj{$i}; "ocrPos"))
		APPEND TO ARRAY:C911(selectedRegExp; OB Get:C1224($arrOCRPayloadObj{$i}; "regExp"))
		APPEND TO ARRAY:C911(selectedPayloadPos; OB Get:C1224($arrOCRPayloadObj{$i}; "payloadPos"))
		
		
	End for 
	fieldsObject:=[OCR_Ids:109]OCRPayLoad:6
	
End if 