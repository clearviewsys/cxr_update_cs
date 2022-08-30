//%attributes = {}
// see also OpenPicture

// loadPictureIntoBlob(path;->picturePtr) ->boolean (success)
C_TEXT:C284($1; $sourcePath)
C_POINTER:C301($2; $picturePtr)
C_BOOLEAN:C305($0)
C_BLOB:C604($myBLOB)

C_TIME:C306($vhDocRef)

$sourcePath:=$1
$picturePtr:=$2

//setErrorTrap ("")
//$vhDocRef:=Open document($sourcePath)
//
//If (OK=1)  // If a document has been chosen
//CLOSE DOCUMENT($vhDocRef)  // We don't need to keep it open
//DOCUMENT TO BLOB(Document;$myBLOB)  // Load the document
//
//If (OK=1)
//BLOB TO PICTURE($myblob;$picturePtr->)
//$0:=True
//Else 
//$0:=False
//End if 
//End if 
//endErrorTrap 

setErrorTrap("")
READ PICTURE FILE:C678($sourcePath; $picturePtr->)
If (OK=1)
	CONVERT PICTURE:C1002($picturePtr->; ".jpg"; 0.6)
	$0:=True:C214
Else 
	$0:=False:C215
End if 

endErrorTrap
