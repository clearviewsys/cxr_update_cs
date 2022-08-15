//%attributes = {}
C_TEXT:C284($branchID)
C_TIME:C306($time)
C_BLOB:C604($blob)

//If (Test path name(DokaFinalPicturePath)=Is a document)
//DOCUMENT TO BLOB(DokaFinalPicturePath;$blob)
//READ WRITE([LinkedDocs])
//BLOB TO PICTURE($blob;[LinkedDocs]ScannedImage)
//End if 

handleSaveButton(->[LinkedDocs:4]; ->$branchID; ->[LinkedDocs:4]creationDate:15; ->$time; ->[LinkedDocs:4]createdByUser:14; ->[LinkedDocs:4]modificationDate:17; ->$time; ->[LinkedDocs:4]modifiedByUser:16)
//validateLinkedDocs

