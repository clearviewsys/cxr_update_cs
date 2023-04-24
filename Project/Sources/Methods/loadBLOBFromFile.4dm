//%attributes = {}
// loadBLOBfromFile (->BLOB;filePath)
// also see: saveBLOBtoFile

C_POINTER:C301($1; $blobPtr)
C_TEXT:C284($documentName; $2)
$blobPtr:=$1
$documentName:=$2
C_TIME:C306($vhDocRef)
setErrorTrap("loadBlobFromFile"; "Error loading the document and transferring into blob")
$vhDocRef:=Open document:C264($documentName)  // Select the document of your choice

If (OK=1)  // If a document has been chosen
	CLOSE DOCUMENT:C267($vhDocRef)  // We don't need to keep it open
	DOCUMENT TO BLOB:C525(Document; $blobPtr->)  // Load the document
	If (OK=0)
		// Handle error
		myAlert("Error in reading BLOB document")
	End if 
End if 
endErrorTrap
