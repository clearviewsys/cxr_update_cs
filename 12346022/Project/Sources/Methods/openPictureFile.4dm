//%attributes = {}
// openPictureFile (->PictureVar)
// this is not the best method as it is throwing an error message
// PRE:
// POST: may throw an error dialog

C_POINTER:C301($1)
C_BLOB:C604($myblob)
C_TIME:C306($vhDocRef)
$vhDocRef:=Open document:C264("")  // Select the document of your choice

If (OK=1)  // If a document has been chosen
	CLOSE DOCUMENT:C267($vhDocRef)  // We don't need to keep it open
	DOCUMENT TO BLOB:C525(Document; $myblob)  // Load the document
	If (OK=1)
		BLOB TO PICTURE:C682($myblob; $1->)
	Else 
		myAlert("Error in opening the file.")
	End if 
End if 
