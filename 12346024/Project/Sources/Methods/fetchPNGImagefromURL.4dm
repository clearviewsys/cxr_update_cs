//%attributes = {}
// fetchPicturefromURL ( domainName; pictureURL) -> picture
// ex : fetchPictureURL( "bankNotes.com";"CA61.JPG")

C_TEXT:C284($1; $2; $domain; $pictureURL)
C_PICTURE:C286(thePicture)
C_BLOB:C604($theBlob)

$domain:=$1
$pictureURL:=$2

$theBlob:=fetchBLOBfromURL($domain; $pictureURL)
C_LONGINT:C283($position)
$position:=Position:C15("âPNG"; BLOB to text:C555($theBlob; Mac text without length:K22:10))
DELETE FROM BLOB:C560($theBlob; 0; $position-1)
//saveBLOBtoFile ($theBlob;"TestBlob")
BLOB TO PICTURE:C682($theBlob; thePicture)
If (OK=0)
	loadPictureResource("failedToLoad"; ->thePicture)
	//GET PICTURE FROM LIBRARY("failedToLoad"; thePicture)
End if 

$0:=thePicture

CLEAR VARIABLE:C89(thePicture)
CLEAR VARIABLE:C89($theBlob)

