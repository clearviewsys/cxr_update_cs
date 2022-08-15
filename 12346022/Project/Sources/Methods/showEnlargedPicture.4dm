//%attributes = {}
// showEnlargedPicture (picture)

C_PICTURE:C286($picture; $1)
C_LONGINT:C283($win)
C_OBJECT:C1216($picObj)

Case of 
	: (Count parameters:C259=1)
		$picture:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
If ($picture#Null:C1517)
	$picObj:=New object:C1471("picture"; $picture)
	//$picObj:=$picturePtr->
	$win:=Open form window:C675("Frame")
	DIALOG:C40("Frame"; $picObj)
End if 
