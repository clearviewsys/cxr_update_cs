//%attributes = {}
// openPictureFile (->PictureVar;{path}): bool
// open a picture from a file path and assigns it to the pictureVar
// return success or not

C_POINTER:C301($1; $picturePtr)

C_TEXT:C284($sourcePath; $2)
C_BOOLEAN:C305($success; $0)

$picturePtr:=$1
Case of 
	: (Count parameters:C259=2)
		$sourcePath:=$2
	Else 
		$sourcePath:=""
End case 

//SHOW ON DISK(getClientPictureIDSource ;*)
If (isPathValid($sourcePath))
	$success:=loadPicture($sourcePath; $picturePtr)
Else 
	$success:=False:C215
End if 

$0:=$success