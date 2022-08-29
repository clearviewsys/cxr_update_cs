//%attributes = {"shared":true}
// ----------------------------------------------------
// Project Method: WAPI_hookOnSaveFile

//  ` This hook is called immediately after a document has saved on disk - document folder.
// You can create/update records with this info

// Access: Shared

// Parameters: $1=Table Pointer = Pointer; t


// Go to the example database to copy the example for this method
// This method was automatically generated by WAPI on Jul 15, 2019.
// WAPI is Copyright 2018 - 2019-- IBB Consulting, LLC 
// ----------------------------------------------------

C_POINTER:C301($1; $ptrTable)
C_TEXT:C284($2; $tInputID)
C_TEXT:C284($3; $tFilename)
C_TEXT:C284($4; $tMimeType)
C_TEXT:C284($5; $tPath)
C_TEXT:C284($6; $tUUID)
C_POINTER:C301($7; $ptrNames)
C_POINTER:C301($8; $ptrValues)

C_LONGINT:C283($0; $iError)

C_PICTURE:C286($picture)
C_REAL:C285($rPercent)
C_LONGINT:C283($iMaxWidth; $iWidth; $iHeight)


$ptrTable:=$1
$tInputID:=$2
$tFilename:=$3
$tMimeType:=$4
$tPath:=$5
$tUUID:=$6

$ptrNames:=$7
$ptrValues:=$8

$iError:=0

//TRACE
Case of 
	: ($ptrTable=(->[WebAttachments:86]))  //already created directly
		
		
	: (Test path name:C476($tPath)=Is a document:K24:1) & (Not:C34(Is nil pointer:C315($ptrTable)))  //all good
		CREATE RECORD:C68([WebAttachments:86])
		[WebAttachments:86]UUID:1:=$tUUID
		[WebAttachments:86]Description:9:=""
		[WebAttachments:86]CXRType:8:=""
		
	Else 
		$iError:=-1
End case 


If ($iError=0)
	
	[WebAttachments:86]FileName:5:=$tFilename
	[WebAttachments:86]CreateDate:4:=Current date:C33
	[WebAttachments:86]CreateTime:7:=Current time:C178
	[WebAttachments:86]CreateUser:6:=WAPI_getSession("username")
	[WebAttachments:86]FilePath:3:=Replace string:C233($tPath; WAPI_uploadsFolder; "")  //convert to relative path to root
	[WebAttachments:86]MimeType:10:=$tMimeType
	[WebAttachments:86]Preview:12:=WAPI_pict2Thumbnail(->$tPath; 0; 96; 0.5)
	
	If ([WebAttachments:86]RelatedTableNum:11=0)
		[WebAttachments:86]RelatedTableNum:11:=Table:C252($ptrTable)
	End if 
	
	Case of 
		: ($ptrTable=(->[eWires:13]))
			[WebAttachments:86]RelatedID:2:=[eWires:13]eWireID:1
			
			If (Picture size:C356([eWires:13]AttachedPicture:25)=0)
				[eWires:13]AttachedPicture:25:=[WebAttachments:86]Preview:12  //<>TODO change to actual picture
			End if 
			
		: ($ptrTable=(->[WebEWires:149]))
			[WebAttachments:86]RelatedID:2:=[WebEWires:149]WebEwireID:1
			
		: ($ptrTable=(->[Customers:3]))
			// dropzone-file[
			If (Position:C15("dropzone-file["; $tInputID)>0)
				$currId:=Num:C11(Substring:C12($tInputID; 14))
			Else 
				$currId:=0
			End if 
			
			[WebAttachments:86]RelatedID:2:=[Customers:3]CustomerID:1
			
			$iMaxWidth:=Num:C11(getKeyValue("web.customers.picture.maxwidth"; "500"))
			$picture:=WAPI_pict2Thumbnail(->$tPath; $iMaxWidth)
			
			
			If ($currId=0)  //(Picture size([Customers]PictureID_Image)=0)
				[Customers:3]PictureID_Image:53:=$picture  //[WebAttachments]Preview  //<>TODO change to actual picture
				[Customers:3]PictureID_IssueCountry:73:=getCountryNameByCode([Customers:3]PictureID_CountryCode:118)
			Else 
				CREATE RECORD:C68([LinkedDocs:4])
				[LinkedDocs:4]LinkedDocID:12:=makeLinkedDocID
				[LinkedDocs:4]UUID:19:=Generate UUID:C1066
				[LinkedDocs:4]RelatedTableNum:23:=Table:C252(->[Customers:3])
				[LinkedDocs:4]RelatedTableID:24:=[Customers:3]CustomerID:1
				[LinkedDocs:4]CustomerID:1:=[Customers:3]CustomerID:1
				
				[LinkedDocs:4]createdByUser:14:=getSystemUserName
				[LinkedDocs:4]creationDate:15:=Current date:C33
				
				[LinkedDocs:4]ScannedImage:2:=$picture  //could this be a thumbnail??? or icon representing mime/type
				[LinkedDocs:4]ScanDate:3:=Current date:C33
				
				[LinkedDocs:4]Description:9:=""
				[LinkedDocs:4]DocReference:6:=""
				[LinkedDocs:4]TypeOfDoc:5:=""
				
				[LinkedDocs:4]PictureIDTemplateID:20:=WAPI_getParameter("customers-pictureid_templateid-input["+String:C10($currId+1)+"]"; ""; $ptrNames; $ptrValues)  //[Customers]PictureID_TemplateID
				[LinkedDocs:4]DocReference:6:=WAPI_getParameter("customers-pictureid_number-input["+String:C10($currId+1)+"]"; ""; $ptrNames; $ptrValues)  //[Customers]PictureID_Number
				[LinkedDocs:4]IssueCity:7:=WAPI_getParameter("customers-pictureid_issuecity-input["+String:C10($currId+1)+"]"; ""; $ptrNames; $ptrValues)  //isn't currently a field in [customers]
				[LinkedDocs:4]IssueCountryCode:18:=WAPI_getParameter("customers-pictureid_countrycode-input["+String:C10($currId+1)+"]"; ""; $ptrNames; $ptrValues)  //
				[LinkedDocs:4]IssueDate:21:=Date:C102(WAPI_getParameter("customers-pictureid_issuedate-input["+String:C10($currId+1)+"]"; ""; $ptrNames; $ptrValues))  //[Customers]PictureID_IssueDate
				[LinkedDocs:4]IssuingAuthority:22:=WAPI_getParameter("customers-pictureid_authority-input["+String:C10($currId+1)+"]"; ""; $ptrNames; $ptrValues)  //[Customers]PictureID_Authority
				[LinkedDocs:4]IssueCountryCode:18:=WAPI_getParameter("customers-pictureid_countrycode-input["+String:C10($currId+1)+"]"; ""; $ptrNames; $ptrValues)  //[Customers]PictureID_CountryCode
				[LinkedDocs:4]ExpiryDate:4:=Date:C102(WAPI_getParameter("customers-pictureid_expirydate-input["+String:C10($currId+1)+"]"; ""; $ptrNames; $ptrValues))  //[Customers]PictureID_ExpiryDate
				[LinkedDocs:4]IssueCountry:8:=getCountryNameByCode([LinkedDocs:4]IssueCountryCode:18)
				
				[LinkedDocs:4]isFlagged:13:=False:C215
				[LinkedDocs:4]filePath:26:=""
				[LinkedDocs:4]fileName:28:=""
				[LinkedDocs:4]mimeType:27:=""
				
				SAVE RECORD:C53([LinkedDocs:4])
			End if 
			
		: ($ptrTable=(->[Links:17]))
			[WebAttachments:86]RelatedID:2:=[Links:17]LinkID:1
			
			If (Picture size:C356([Links:17]PictureID:53)=0)
				
				$iMaxWidth:=Num:C11(getKeyValue("web.customers.picture.maxwidth"; "500"))
				$picture:=WAPI_pict2Thumbnail(->$tPath; $iMaxWidth)
				
				[Links:17]PictureID:53:=$picture  //<>TODO change to actual picture
			End if 
			
	End case 
	
	
	SAVE RECORD:C53([WebAttachments:86])
	
End if 

$0:=$iError
