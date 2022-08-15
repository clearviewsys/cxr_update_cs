//%attributes = {}
// OCR_SavePayload 
// Saves the payload after scanning an ID
// TODO: Fix Objects

Case of 
	: (Count parameters:C259=0)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($fieldObj)
ARRAY TEXT:C222($arrFieldObj; 0)
ARRAY TEXT:C222($arrRegExpObj; 0)

C_LONGINT:C283($payLoadPos; $ocrPos; $i)
C_TEXT:C284($fieldName; $refCode; $country; $regExp; $textOCRResultObj; $textfieldsObject; $textRegExp; $msg; $example; $fieldCode)
C_TEXT:C284($idCode; $idName)
C_PICTURE:C286($docPhoto)

$idCode:=[OCR_Ids:109]Code:2
$idName:=[OCR_Ids:109]Name:3
$docPhoto:=[OCR_Ids:109]Photo:4

docModified:=False:C215



ARRAY OBJECT:C1221($arrObj; 0)

C_OBJECT:C1216($obj)
ARRAY OBJECT:C1221($list; 0)

For ($i; 1; Size of array:C274(selectedFieldCode))
	
	OB SET:C1220($obj; "fieldCode"; selectedFieldCode{$i})
	OB SET:C1220($obj; "fieldName"; selectedFieldName{$i})
	OB SET:C1220($obj; "fieldName"; selectedExample{$i})
	
	$ocrPos:=selectedOCRPos{$i}
	OB SET:C1220($obj; "ocrPos"; $ocrPos)
	
	OB SET:C1220($obj; "payloadPos"; selectedPayloadPos{$i})
	OB SET:C1220($obj; "regExp"; selectedRegExp{$i})
	
	//APPEND TO ARRAY($list;$obj) // throws a syntax error 
	CLEAR VARIABLE:C89($obj)
	
End for 

OB SET ARRAY:C1227([OCR_Ids:109]OCRPayLoad:6; "arrFields"; $list)
OB SET ARRAY:C1227([OCR_Ids:109]OCRResult:5; "arrFields"; arrOCRResult)

