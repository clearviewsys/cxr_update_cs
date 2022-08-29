//%attributes = {}
// openPictureFile (->PictureVar;{path})

C_POINTER:C301($1; $picturePtr)

C_TEXT:C284($sourcePath; $2)
C_BOOLEAN:C305($success)

$picturePtr:=$1
Case of 
	: (Count parameters:C259=2)
		$sourcePath:=$2
	Else 
		$sourcePath:=""
End case 

//SHOW ON DISK(getClientPictureIDSource ;*)

$success:=loadPicture($sourcePath; $picturePtr)
