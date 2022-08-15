HandleEntryForm(->[LinkedDocs:4]; ->[LinkedDocs:4]createdByUser:14; ->[LinkedDocs:4]modifiedByUser:16)

If (Form event code:C388=On Load:K2:1)
	If (Records in selection:C76([Customers:3])=0)
		RELATE ONE:C42([LinkedDocs:4]CustomerID:1)  // load the customer record if it's not already loaded. 
	End if 
	
	If (Is new record:C668([LinkedDocs:4]))  //3/28/20 IBB
		If (Current default table:C363=(->[Customers:3])) | (Is nil pointer:C315(Current default table:C363))
		Else   //set the related table and id
			
			//$tTableName:=Table name(Current default table)
			//$tFieldName:="["+$tTableName+"]"
			//If (Substring($tTableName;Length($tTableName);1)="s")  //ends with s
			//$tFieldName:=$tFieldName+Substring($tTableName;1;Length($tTableName)-1)+"ID"
			//Else 
			//$tFieldName:=$tFieldName+$tTableName+"ID"
			//End if 
			//$ptrField:=UTIL_getFieldPointer ($tFieldName)
			
			C_POINTER:C301($ptrField)
			$ptrField:=getPrimaryKeyFieldPtr(Current default table:C363; True:C214)
			If (Is nil pointer:C315($ptrField))  //didn't find a field
			Else 
				[LinkedDocs:4]RelatedTableNum:23:=Table:C252(Current default table:C363)
				[LinkedDocs:4]RelatedTableID:24:=$ptrField->
			End if 
		End if 
	End if 
	
End if 


If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))  // on demand or on load
	// Load Picture into 
	If (Picture size:C356([LinkedDocs:4]ScannedImage:2)>0)
		PE_LoadPictureInArea(->[LinkedDocs:4]ScannedImage:2; "picWArea")
		C_TEXT:C284(vSizeOfImage)
	End if 
	handleSizeOfImageVar(->vSizeOfImage; ->[LinkedDocs:4]ScannedImage:2; "vSizeOfImage")
	
End if 
