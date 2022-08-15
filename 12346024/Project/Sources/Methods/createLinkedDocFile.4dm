//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 08/04/20, 20:46:59
// ----------------------------------------------------
// Method: createLinkedDoc
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1; $ptrTable)
C_TEXT:C284($2; $filePath)


C_POINTER:C301($ptrField)
C_BOOLEAN:C305($doSave)


$ptrTable:=$1
$filePath:=$2


$ptrField:=UTIL_getPrimaryKey($ptrTable)

If (Is nil pointer:C315($ptrField))  //nothing to do
Else 
	If (Is new record:C668([LinkedDocs:4]))  // already created 
		$doSave:=False:C215
	Else 
		CREATE RECORD:C68($ptrTable->)
		
		[LinkedDocs:4]LinkedDocID:12:=makeLinkedDocID
		[LinkedDocs:4]UUID:19:=Generate UUID:C1066
		[LinkedDocs:4]RelatedTableNum:23:=Table:C252($ptrTable)
		[LinkedDocs:4]RelatedTableID:24:=$ptrField->
		
		$ptrField:=UTIL_getCustomerIDPtr($ptrTable)
		If (Is nil pointer:C315($ptrField)=False:C215)
			[LinkedDocs:4]CustomerID:1:=$ptrField->
		End if 
		
		[LinkedDocs:4]createdByUser:14:=getSystemUserName
		[LinkedDocs:4]creationDate:15:=Current date:C33
		
		$doSave:=True:C214
	End if 
	
	
	//[LinkedDocs]Description:=
	//[LinkedDocs]DocReference:=
	//[LinkedDocs]ScannedImage:=  `could this be a thumbnail??? or icon representing mime/type
	
	
	If (False:C215)  //not currently used for file based linkedDocs
		//[LinkedDocs]PictureIDTemplateID:=
		//[LinkedDocs]IssueCity:=
		//[LinkedDocs]IssueCountry:=
		//[LinkedDocs]IssueDate:=
		//[LinkedDocs]IssuingAuthority:=
		//[LinkedDocs]IssueCountryCode:=
		//[LinkedDocs]ScanDate:=
		//[LinkedDocs]ExpiryDate:=
		//[LinkedDocs]TypeOfDoc:=
	End if 
	
	C_BLOB:C604($xBlob)
	DOCUMENT TO BLOB:C525($filePath; $xBlob)
	
	[LinkedDocs:4]isFlagged:13:=False:C215
	//[LinkedDocs]filePath:=iH_documentPutPath($filePath)
	[LinkedDocs:4]fileName:28:=UTIL_LongNameToFileName($filePath)
	[LinkedDocs:4]mimeType:27:=MIME_GetTypeByExtension(UTIL_filenameToExtension($filePath))
	[LinkedDocs:4]filePath:26:=putWebAttachmentToServer($xBlob; [LinkedDocs:4]fileName:28)
	
	If ([LinkedDocs:4]fileName:28="@.pdf")
		READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"icons"+Folder separator:K24:12+"pdf-icon.jpeg"; [LinkedDocs:4]ScannedImage:2)
	Else 
		[LinkedDocs:4]ScannedImage:2:=WAPI_pict2Thumbnail(->$filePath; 0; 96; 0.5)
	End if 
	
	
	If ($doSave)
		SAVE RECORD:C53([LinkedDocs:4])
	End if 
End if 