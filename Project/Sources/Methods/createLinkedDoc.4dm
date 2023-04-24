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


$ptrTable:=$1
$filePath:=$2


//$ptrField:=UTIL_getPrimaryKey ($ptrTable)

$ptrField:=getPrimaryKeyFieldPtr($ptrTable; True:C214)

If (Is nil pointer:C315($ptrField))  //nothing to do
Else 
	CREATE RECORD:C68([LinkedDocs:4])
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
	[LinkedDocs:4]ScanDate:3:=Current date:C33
	[LinkedDocs:4]IssueDate:21:=Current date:C33
	[LinkedDocs:4]ExpiryDate:4:=Current date:C33
	
	[LinkedDocs:4]isFlagged:13:=False:C215
	[LinkedDocs]sourcePath:=$filePath
	[LinkedDocs:4]fileName:28:=UTIL_LongNameToFileName($filePath)
	[LinkedDocs:4]mimeType:27:=MIME_GetTypeByExtension(UTIL_filenameToExtension($filePath))
	[LinkedDocs:4]TypeOfDoc:5:="*"
	[LinkedDocs:4]Description:9:=[LinkedDocs:4]fileName:28
	
	//If (Is picture file($filePath)) & ($filePath#"@.pdf")
	If ([LinkedDocs:4]mimeType:27="image/@")
		READ PICTURE FILE:C678($filePath; [LinkedDocs:4]ScannedImage:2)  //could this be a thumbnail??? or icon representing mime/type
	Else 
		[LinkedDocs:4]filePath:26:=DOC_storeDocumentPath($filePath)
		
		Case of 
			: ([LinkedDocs:4]mimeType:27="application/pdf")
				If (Is macOS:C1572)
					C_PICTURE:C286($pict)  // 12/04/2006 -- I. Barclay Berry
					READ PICTURE FILE:C678($filePath; $pict)  // 12/04/2006 -- I. Barclay Berry
					CREATE THUMBNAIL:C679($pict; [LinkedDocs:4]ScannedImage:2; 204; 264)  // 12/04/2006 -- I. Barclay Berry
					CONVERT PICTURE:C1002([LinkedDocs:4]ScannedImage:2; ".JPG"; 0.5)
				Else 
					READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"icons"+Folder separator:K24:12+"pdf-icon.jpeg"; [LinkedDocs:4]ScannedImage:2)
				End if 
				
			Else 
				
		End case 
		
	End if 
	
	
	If (False:C215)  //not currently used for file based linkedDocs
		//[LinkedDocs]Description:=
		//[LinkedDocs]DocReference:=
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
	
	
	
	SAVE RECORD:C53([LinkedDocs:4])
	
End if 