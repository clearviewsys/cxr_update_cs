//%attributes = {}
// displayPicture (->picture)
// opens a form to display a picture

C_OBJECT:C1216($obj)
C_POINTER:C301($picturePtr)

Case of 
	: (Count parameters:C259=1)
		$picturePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$obj:=New object:C1471
If (Is nil pointer:C315($picturePtr))
	// picture is empty
Else 
	$obj.picture:=$picturePtr->
	C_LONGINT:C283($win)
	$win:=Open form window:C675("PictureViewer"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("PictureViewer"; $obj)
End if 