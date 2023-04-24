C_POINTER:C301($ptrField; $ptrTable)
C_TEXT:C284($localPath)

HandleEntryForm(->[LinkedDocs:4]; ->[LinkedDocs:4]createdByUser:14; ->[LinkedDocs:4]modifiedByUser:16)


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (Records in selection:C76([Customers:3])=0)
			RELATE ONE:C42([LinkedDocs:4]CustomerID:1)  // load the customer record if it's not already loaded. 
		End if 
		
		If (Is new record:C668([LinkedDocs:4]))  //3/28/20 IBB
			
			$ptrTable:=Current default table:C363
			
			If ($ptrTable=(->[Customers:3])) | (Is nil pointer:C315($ptrTable))
			Else   //set the related table and id
				
				$ptrField:=UTIL_getCustomerIDPtr($ptrTable)
				If (Is nil pointer:C315($ptrField)=False:C215)
					[LinkedDocs:4]CustomerID:1:=$ptrField->
				End if 
				
				$ptrField:=getPrimaryKeyFieldPtr($ptrTable; True:C214)
				If (Is nil pointer:C315($ptrField))  //didn't find a field
				Else 
					[LinkedDocs:4]RelatedTableNum:23:=Table:C252($ptrTable)
					[LinkedDocs:4]RelatedTableID:24:=$ptrField->
				End if 
			End if 
		End if 
		
		POST OUTSIDE CALL:C329(Current process:C322)
		
		
	: (Form event code:C388=On Timer:K2:25)
		//displayCustomersLInkedDocs
		SET TIMER:C645(0)
		
	: (Form event code:C388=On Outside Call:K2:11)
		
		Case of 
			: ([LinkedDocs:4]mimeType:27#"image/@")  //display in browser
				FORM GOTO PAGE:C247(3)
				
				// load document in web area - PDF
				$localPath:=DOC_retrieveDocumentPath([LinkedDocs:4]filePath:26)  //;$localPath;$doDelete)
				If (Is macOS:C1572)
					$localPath:="file://"+Convert path system to POSIX:C1106($localPath)
				End if 
				
				WA OPEN URL:C1020(webArea; $localPath)
				OBJECT SET VISIBLE:C603(*; "tabControl_Edit"; False:C215)
				
			Else 
				FORM GOTO PAGE:C247(1)
				// Load Picture into 
				If (Picture size:C356([LinkedDocs:4]ScannedImage:2)>0)
					PE_LoadPictureInArea(->[LinkedDocs:4]ScannedImage:2; "picWArea")
					C_TEXT:C284(vSizeOfImage)
					iH_Notify("Tip"; "If you are using Edit+ after finishing the Picture edition press button DONE and then button SAVE"; 6)
				End if 
				handleSizeOfImageVar(->vSizeOfImage; ->[LinkedDocs:4]ScannedImage:2; "vSizeOfImage")
				
		End case 
		
End case 

