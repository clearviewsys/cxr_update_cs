C_TEXT:C284($formPath)
C_BLOB:C604($blobDocument)

UNLOAD RECORD:C212([LinkedDocs:4])
REDUCE SELECTION:C351([LinkedDocs:4]; 0)

CREATE RECORD:C68([LinkedDocs:4])

If (Not:C34(Undefined:C82(Form:C1466.filePath)))
	[LinkedDocs:4]Description:9:=Form:C1466.description
	[LinkedDocs:4]fileName:28:=Form:C1466.fileName
	[LinkedDocs:4]mimeType:27:=Form:C1466.mimeType
	$formPath:=Form:C1466.filePath
	DOCUMENT TO BLOB:C525($formPath; $blobDocument)
	[LinkedDocs:4]filePath:26:=putWebAttachmentToServer($blobDocument; [LinkedDocs:4]fileName:28)
	If ([WebAttachments:86]CreateDate:4=!00-00-00!)
		[LinkedDocs:4]creationDate:15:=Current date:C33(*)
	End if 
	If ([LinkedDocs:4]createdByUser:14="")
		[LinkedDocs:4]createdByUser:14:=Form:C1466.createdByUser
	End if 
	
	If (Form:C1466.isFlagged=1)
		[LinkedDocs:4]isFlagged:13:=True:C214
	Else 
		[LinkedDocs:4]isFlagged:13:=False:C215
	End if 
	
	If ([LinkedDocs:4]CustomerID:1="")
		[LinkedDocs:4]CustomerID:1:=[Customers:3]CustomerID:1
	End if 
	If ([LinkedDocs:4]RelatedTableNum:23=Null:C1517)
		[LinkedDocs:4]RelatedTableNum:23:=Table:C252(->[Customers:3])
	End if 
	If ([LinkedDocs:4]RelatedTableID:24="")
		[LinkedDocs:4]RelatedTableID:24:=[Customers:3]CustomerID:1
	End if 
	
End if 

SAVE RECORD:C53([LinkedDocs:4])