
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		C_OBJECT:C1216($result)
		C_OBJECT:C1216($fieldObj)
		C_LONGINT:C283($countDetected)
		C_BOOLEAN:C305($detected)
		
		ARRAY OBJECT:C1221($arrFieldsObj; 0)
		CLEAR VARIABLE:C89(arrFieldsOCR)
		CLEAR VARIABLE:C89(arrValuesOCR)
		ARRAY TEXT:C222(arrTextsOCR; 0)  // OCR Result Texts array
		
		
		
		// Scan the ID 
		OCR_ScanPicture(->arrTextsOCR; ->docPhoto; lang; True:C214)
		OBJECT SET ENABLED:C1123(*; "bClose"; True:C214)
		
		
		// Using the template selected get the results
		C_TEXT:C284($idType)
		$idType:=arrDocCode{arrDocName}  // ID Template to use
		OCR_GetPictureFields(->arrTextsOCR; $idType; ->$result; ->arrFieldsDefinedOCR; ->arrFieldsPositionOCR; ->arrFieldsDefinedCodeOCR; ->arrFieldsDefinedKeywordsOCR)
		
		
		// Display results in listboxes
		
		$countDetected:=0
		
		OB GET ARRAY:C1229($result; "arrFields"; $arrFieldsObj)
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274($arrFieldsObj))
			$fieldObj:=$arrFieldsObj{$i}
			APPEND TO ARRAY:C911(arrFieldsOCR; OB Get:C1224($fieldObj; "fieldName"))
			APPEND TO ARRAY:C911(arrValuesOCR; OB Get:C1224($fieldObj; "fieldValue"))
			$detected:=OB Get:C1224($fieldObj; "fieldConfirmed"; Is boolean:K8:9)
			
			
			If ($detected)
				$countDetected:=$countDetected+1
			End if 
			
		End for 
		
		// Set the % 
		C_REAL:C285($val)
		$val:=($countDetected/Size of array:C274(arrFieldsDefinedOCR))*100
		porc:=Round:C94($val; 1)
		
		// Set Height of Listboxes
		OCR_SetListboxRowHeight(->arrFieldsOCR; ->lbScanned)
		OCR_SetListboxRowHeight(->arrFieldsDefinedOCR; ->lbDefinedFields)
		OCR_SetListboxRowHeight(->arrTextsOCR; ->lbOCRResult)
		
End case 

