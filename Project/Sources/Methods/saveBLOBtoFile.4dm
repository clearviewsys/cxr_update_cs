//%attributes = {}
// saveBLOBtoFile( blob; fileName)
// see loadBlobFromFile


C_BLOB:C604($1)
C_TEXT:C284($documentName; $2)
C_TIME:C306($vhDocRef)
$documentName:=$2


setErrorTrap("saveBlobToFile"; "Error during saving the object!")

$vhDocRef:=Create document:C266($documentName)  // Save the document of your choice

If (OK=1)  // If a document has been created
	CLOSE DOCUMENT:C267($vhDocRef)  // We don't need to keep it open
	BLOB TO DOCUMENT:C526(Document; $1)  // Write the document contents
	If (OK=0)
		myAlert("Error in writing the document")
		// Handle error
	End if 
End if 

endErrorTrap

