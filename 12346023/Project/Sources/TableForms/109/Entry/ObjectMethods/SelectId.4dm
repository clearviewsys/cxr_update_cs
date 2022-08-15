
C_TEXT:C284($doc)
C_BLOB:C604($blob)
C_LONGINT:C283($options; $picSize)

Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		$options:=Alias selection:K24:10+Package open:K24:8
		$doc:=Select document:C905(System folder:C487(Desktop:K41:16); "*"; GetLocalizedErrorMessage(4223); $options)  // 4223: Select Picture for the ID
		
		If (OK=1)
			
			DOCUMENT TO BLOB:C525(Document; $blob)
			BLOB TO PICTURE:C682($blob; [OCR_Ids:109]Photo:4)
			$picSize:=Picture size:C356([OCR_Ids:109]Photo:4)
			
			checkInit
			checkIfPictureSizeIsLT(->[OCR_Ids:109]Photo:4; 1000*1024)
			
			If (isValidationConfirmed)
				OBJECT SET ENABLED:C1123(*; "scanButton"; True:C214)
				
				CLEAR VARIABLE:C89(arrPayload)
				CLEAR VARIABLE:C89(fieldsObject)
				CLEAR VARIABLE:C89(arrOCRResult)
				CLEAR VARIABLE:C89(arrUsedFields)
				
				C_OBJECT:C1216(fieldsObject)
				
			Else 
				OBJECT SET ENABLED:C1123(*; "scanButton"; False:C215)
			End if 
			
		End if 
		
End case 
