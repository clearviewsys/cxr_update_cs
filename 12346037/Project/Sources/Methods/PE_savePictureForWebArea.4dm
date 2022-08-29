//%attributes = {}

// PE_savePictureForWebArea


C_POINTER:C301($1; $picturePtr)
C_TEXT:C284(PictureFilePath)

C_PICTURE:C286($picture)
C_BLOB:C604($pictureBlob)
C_TEXT:C284($resourcesFolder; $tmpFile; $picUrlPath; $destPath)


Case of 
	: (Count parameters:C259=0)
		$picturePtr:=->[LinkedDocs:4]ScannedImage:2
		
	: (Count parameters:C259=1)
		$picturePtr:=$1
		
	Else 
		ASSERT:C1129(False:C215; "Invalid number or parameters to function PR_EditPicture")
End case 

$resourcesFolder:=Get 4D folder:C485(Current resources folder:K5:16; *)

// Save picture and create the file for the Pic Editor utility
If (Picture size:C356($picturePtr->)>0)
	
	CONVERT PICTURE:C1002($picturePtr->; ".jpg")
	PICTURE TO BLOB:C692($picturePtr->; $pictureBlob; "image/jpg")
	
	$tmpFile:=Temporary folder:C486+"pic_"+String:C10(Random:C100)+".jpg"
	
	// Save the picture into the temp 4d Directory
	BLOB TO DOCUMENT:C526($tmpFile; $pictureBlob)
	
	
	// Set destination path 
	$destPath:=$resourcesFolder+"tui_ieditor"+Folder separator:K24:12+"cvs"+Folder separator:K24:12+"myPicture.jpg"
	
	// Delete document if exists
	If (Test path name:C476($destPath)=Is a document:K24:1)
		DELETE DOCUMENT:C159($destPath)
	End if 
	
	COPY DOCUMENT:C541($tmpFile; $destPath; *)
	DokaFinalPicturePath:=$tmpFile
	
	
	
Else 
	ALERT:C41("You should select a Picture first")
End if 
