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

C_LONGINT:C283($payLoadPos; $ocrPos)
C_TEXT:C284($fieldName; $refCode; $country; $regExp; $textOCRResultObj; $textfieldsObject; $textRegExp; $msg; $example; $fieldCode)
C_TEXT:C284($idCode; $idName)
C_PICTURE:C286($docPhoto)

$idCode:=[OCR_Ids:109]Code:2
$idName:=[OCR_Ids:109]Name:3
$docPhoto:=[OCR_Ids:109]Photo:4

docModified:=False:C215


Begin SQL
	DELETE FROM OCR_FieldsxID WHERE idCode = :$idCode;
End SQL

C_OBJECT:C1216($obj; $list2)
ARRAY OBJECT:C1221($list; 0)
C_LONGINT:C283($i)

For ($i; 1; Size of array:C274(selectedFieldCode))
	
	$fieldCode:=selectedFieldCode{$i}
	OB SET:C1220($obj; "fieldCode"; selectedFieldCode{$i})
	OB SET:C1220($obj; "fieldName"; selectedFieldName{$i})
	OB SET:C1220($obj; "example"; selectedExample{$i})
	
	$ocrPos:=selectedOCRPos{$i}
	OB SET:C1220($obj; "ocrPos"; $ocrPos)
	OB SET:C1220($obj; "payloadPos"; selectedPayloadPos{$i})
	OB SET:C1220($obj; "regExp"; selectedRegExp{$i})
	APPEND TO ARRAY:C911($list; $obj)
	
	Begin SQL
		
		INSERT INTO OCR_FieldsxID 
		(seq, IdCode, fieldCode, OCRPos )  VALUES 
		(:$i, :$idCode, :$fieldCode,:$ocrPos );
		
	End SQL
	
End for 

OB SET ARRAY:C1227($obj; "arrFields"; $list)
[OCR_Ids:109]OCRPayLoad:6:=OB Copy:C1225($obj)

CLEAR VARIABLE:C89($list)
CLEAR VARIABLE:C89($obj)

CLEAR VARIABLE:C89($obj)
OB SET ARRAY:C1227($obj; "arrFields"; arrOCRResult)

[OCR_Ids:109]OCRResult:5:=OB Copy:C1225($obj)
SAVE RECORD:C53([OCR_Ids:109])


