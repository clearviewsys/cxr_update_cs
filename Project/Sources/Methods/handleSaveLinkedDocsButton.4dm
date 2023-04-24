//%attributes = {}
C_TEXT:C284($branchID)
C_TIME:C306($time)
C_BLOB:C604($blob)

C_TEXT:C284(DokaFinalPicturePath)

If (Test path name:C476(DokaFinalPicturePath)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525(DokaFinalPicturePath; $blob)
	DokaFinalPicturePath:=""
	
	//If (Is new record([LinkedDocs])=False)
	//READ WRITE([LinkedDocs])
	//LOAD RECORD([LinkedDocs])
	//End if 
	
	BLOB TO PICTURE:C682($blob; [LinkedDocs:4]ScannedImage:2)
	
	//If (Is new record([LinkedDocs])=False)
	//SAVE RECORD([LinkedDocs])
	//End if 
End if 


handleSaveButton(->[LinkedDocs:4]; ->$branchID; ->[LinkedDocs:4]creationDate:15; ->$time; ->[LinkedDocs:4]createdByUser:14; ->[LinkedDocs:4]modificationDate:17; ->$time; ->[LinkedDocs:4]modifiedByUser:16)
//validateLinkedDocs

