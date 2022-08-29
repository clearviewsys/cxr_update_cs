C_POINTER:C301($ptrField; $ptrTable)

HandleEntryForm(->[LinkedDocs:4]; ->[LinkedDocs:4]createdByUser:14; ->[LinkedDocs:4]modifiedByUser:16)
C_TEXT:C284(newAttchmentfilePath)


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
		displayCustomersLInkedDocs
		SET TIMER:C645(0)
		
	: (Form event code:C388=On Outside Call:K2:11)
		
		Case of 
			: (False:C215)
				FORM GOTO PAGE:C247(3)
				
			: ((Undefined:C82(newAttchmentfilePath)=True:C214))
				If ([LinkedDocs:4]filePath:26#"")
					FORM GOTO PAGE:C247(3)
					SET TIMER:C645(-1)
					//displayCustomersLInkedDocs
				Else 
					FORM GOTO PAGE:C247(1)
				End if 
			: (newAttchmentfilePath="")
				If ([LinkedDocs:4]filePath:26#"")
					FORM GOTO PAGE:C247(3)
					SET TIMER:C645(-1)
					//displayCustomersLInkedDocs
				Else 
					FORM GOTO PAGE:C247(1)
				End if 
			Else 
				createLinkedDocsRecordFromPath(newAttchmentfilePath)
				newAttchmentfilePath:=""
		End case 
		
		
		// Load Picture into 
		If (Picture size:C356([LinkedDocs:4]ScannedImage:2)>0)
			PE_LoadPictureInArea(->[LinkedDocs:4]ScannedImage:2; "picWArea")
			C_TEXT:C284(vSizeOfImage)
			iH_Notify("Tip"; "If you are using Edit+ after finishing the Picture edition press button DONE and then button SAVE"; 6)
			
		End if 
		handleSizeOfImageVar(->vSizeOfImage; ->[LinkedDocs:4]ScannedImage:2; "vSizeOfImage")
		
		
		
End case 


//If ((Form event code=On Load) | (Form event code=On Outside Call))  // on demand or on load

//Case of 
//: (False)
//FORM GOTO PAGE(3)

//: ((Undefined(newAttchmentfilePath)=True))
//If ([LinkedDocs]filePath#"")
//FORM GOTO PAGE(3)
//displayCustomersLInkedDocs
//Else 
//FORM GOTO PAGE(1)
//End if 
//: (newAttchmentfilePath="")
//If ([LinkedDocs]filePath#"")
//FORM GOTO PAGE(3)
//displayCustomersLInkedDocs
//Else 
//FORM GOTO PAGE(1)
//End if 
//Else 
//createLinkedDocsRecordFromPath(newAttchmentfilePath)
//newAttchmentfilePath:=""
//End case 

//// Load Picture into 
//If (Picture size([LinkedDocs]ScannedImage)>0)
//PE_LoadPictureInArea(->[LinkedDocs]ScannedImage; "picWArea")
//C_TEXT(vSizeOfImage)
//End if 
//handleSizeOfImageVar(->vSizeOfImage; ->[LinkedDocs]ScannedImage; "vSizeOfImage")

//End if 
