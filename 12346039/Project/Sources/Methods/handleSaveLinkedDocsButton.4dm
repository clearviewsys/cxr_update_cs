//%attributes = {}
C_TEXT:C284($branchID)
C_TIME:C306($time)
C_BLOB:C604($blob)

If (Test path name:C476(DokaFinalPicturePath)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525(DokaFinalPicturePath; $blob)
	
	READ WRITE:C146([LinkedDocs:4])
	LOAD RECORD:C52([LinkedDocs:4])
	BLOB TO PICTURE:C682($blob; [LinkedDocs:4]ScannedImage:2)
	SAVE RECORD:C53([LinkedDocs:4])
	
End if 


handleSaveButton(->[LinkedDocs:4]; ->$branchID; ->[LinkedDocs:4]creationDate:15; ->$time; ->[LinkedDocs:4]createdByUser:14; ->[LinkedDocs:4]modificationDate:17; ->$time; ->[LinkedDocs:4]modifiedByUser:16)
//validateLinkedDocs

