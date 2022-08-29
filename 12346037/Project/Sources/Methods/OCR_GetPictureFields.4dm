//%attributes = {}
// OCR_GetPictureFields ( ->arrOCRResult; $idType; ->jsonObject; ->arrDefinedFields; ->$arrDefinedOCRPosPtr ; ->arrDefinedFieldCodes)
// Scan a Picture field using fields defined for $idType
// Created By CVS Dev. Team, 04/22/2017

C_POINTER:C301($1; $arrOCRResultPtr; $3; $jsonObjectPtr; $4; $arrDefinedFieldsPtr; $5; $arrDefinedOCRPosPtr; $6; $arrDefinedFieldCodesPtr; $7; $arrFieldsDefinedKeywordsOCRPtr)
C_TEXT:C284($2; $idType)
C_TEXT:C284($path; $tmp)
C_LONGINT:C283($i; $j; $k; $m; $pos)
C_OBJECT:C1216($responseObj; $fieldObj)

ARRAY TEXT:C222($arrFieldObj; 0)
ARRAY TEXT:C222($arrFieldCode; 0)
ARRAY TEXT:C222($arrFieldName; 0)
ARRAY TEXT:C222($arrFieldRegExp; 0)
ARRAY TEXT:C222($arrKeywords; 0)

ARRAY LONGINT:C221($arrSeq; 0)
ARRAY LONGINT:C221($arrOCRPos; 0)

Case of 
		
	: (Count parameters:C259=7)
		
		$arrOCRResultPtr:=$1
		$idType:=$2
		$jsonObjectPtr:=$3
		$arrDefinedFieldsPtr:=$4
		$arrDefinedOCRPosPtr:=$5
		$arrDefinedFieldCodesPtr:=$6
		$arrFieldsDefinedKeywordsOCRPtr:=$7
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_OBJECT:C1216($responseObj)
C_OBJECT:C1216($fieldObj)


ARRAY BOOLEAN:C223($arrOCRResultConfirmed; Size of array:C274($arrOCRResultPtr->))

If (Size of array:C274($arrOCRResultPtr->)>0)
	
	OCR_CleanScannedText($arrOCRResultPtr)
	
	Begin SQL
		
		SELECT fxi.seq, fxi.OCRPos, f.keyword, f.fieldRegExp, f.fieldCode
		FROM OCR_Ids as i, OCR_FieldsxID as fxi, OCR_Fields AS f 
		WHERE i.Code = :$idType  AND i.code=fxi.IdCode  AND  fxi.fieldCode = f.fieldCode
		ORDER BY fxi.OCRPos ASC
		INTO :$arrSeq, :$arrOCRPos, :$arrKeywords, :$arrFieldRegExp, :$arrFieldCode
		
	End SQL
	
	For ($i; 1; Size of array:C274($arrKeywords))
		APPEND TO ARRAY:C911($arrFieldName; OCR_SplitAndLocalizeFieldName($arrKeywords{$i}))
	End for 
	
	
	
	// Build the Object Response
	ARRAY LONGINT:C221($arrOCRPosReal; Size of array:C274($arrFieldName))
	
	For ($i; 1; Size of array:C274($arrFieldName))
		$arrOCRPosReal{$i}:=-1
		$pos:=-1
		// Add the field to result only if the Regexp matches
		
		If ($arrOCRPos{$i}<=Size of array:C274($arrOCRResultPtr->))
			$arrOCRResultConfirmed{$i}:=False:C215
			//$arrOCRPos{$i}:=Size of array($arrOCRResultPtr->)
			
			If (Match regex:C1019($arrFieldRegExp{$i}; $arrOCRResultPtr->{$arrOCRPos{$i}}))
				$pos:=$arrOCRPos{$i}
				$arrOCRResultConfirmed{$i}:=True:C214
			Else 
				
				If (($arrOCRPos{$i}+1)<=Size of array:C274($arrOCRPos))
					$m:=$arrOCRPos{$i}+1
				Else 
					$m:=Size of array:C274($arrOCRPos)
				End if 
				
				If (($i+1)<=Size of array:C274($arrOCRPos))
					$k:=$arrOCRPos{$i+1}-1
				Else 
					$k:=Size of array:C274($arrOCRResultPtr->)
				End if 
				
				If (OCR_SearchRegExpInArray($arrFieldRegExp{$i}; $arrOCRResultPtr; $m; $k; ->$pos; ->$arrOCRPosReal))
					$arrOCRResultConfirmed{$i}:=True:C214
				Else 
					If (($i-1)>0)
						$m:=$arrOCRPos{$i-1}+1
					Else 
						$m:=1
					End if 
					
					$k:=$arrOCRPos{$i}-1
					If (OCR_SearchRegExpInArray($arrFieldRegExp{$i}; $arrOCRResultPtr; $m; $k; ->$pos; ->$arrOCRPosReal))
						$arrOCRResultConfirmed{$i}:=True:C214
					End if 
				End if 
				
			End if 
			
			
			CLEAR VARIABLE:C89($fieldObj)
			
			
			If ($arrOCRResultConfirmed{$i})
				$arrOCRPosReal{$i}:=$pos
			End if 
		End if 
		
	End for 
	
	// Try to find all the missing vars into the OCR Result stating on the begining
	// if math with the regular expression it will be used
	
	ARRAY OBJECT:C1221($list; 0)
	
	For ($i; 1; Size of array:C274($arrFieldName))
		CLEAR VARIABLE:C89($fieldObj)
		C_OBJECT:C1216($fieldObj)
		
		If ($arrOCRResultConfirmed{$i})
			$tmp:="[ "+String:C10($arrOCRPosReal{$i})+" ]"
			OB SET:C1220($fieldObj; "fieldName"; $arrFieldName{$i}+$tmp; "fieldValue"; $arrOCRResultPtr->{$arrOCRPosReal{$i}}; "fieldConfirmed"; True:C214)
		Else 
			OB SET:C1220($fieldObj; "fieldName"; $arrFieldName{$i}; "fieldValue"; "NOT DETECTED"; "fieldConfirmed"; False:C215)
		End if 
		
		
		APPEND TO ARRAY:C911($list; $fieldObj)
		
		
	End for 
	//APPEND TO ARRAY($arrFieldObj;$fieldObj)
	
	//$fieldObj:=json_newObject 
	// json_addObj (->$fieldObj;$list;"arrFields")
	//$arrFieldObj:=$fieldObj
	
	
	If (Size of array:C274($arrFieldName)>0)
		OB SET ARRAY:C1227($responseObj; "arrFields"; $arrFieldObj)
		
		
		$jsonObjectPtr->:=OB Copy:C1225($responseObj)
		//$jsonObjectPtr->:=$responseObj
		
		COPY ARRAY:C226($arrFieldName; $arrDefinedFieldsPtr->)
		COPY ARRAY:C226($arrOCRPos; $arrDefinedOCRPosPtr->)
		COPY ARRAY:C226($arrFieldCode; $arrDefinedFieldCodesPtr->)
		COPY ARRAY:C226($arrKeywords; $arrFieldsDefinedKeywordsOCRPtr->)
		
	End if 
	
End if 
