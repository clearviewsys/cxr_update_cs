//%attributes = {}
// loadPictureIntoBlob(path;->picturePtr) ->boolean (success)

C_TEXT:C284($1; $sourcePath)
C_POINTER:C301($2; $picturePtr)
C_BOOLEAN:C305($0)

C_LONGINT:C283($iHeight; $iWidth)
C_REAL:C285($rScale)


$sourcePath:=$1
$picturePtr:=$2

setErrorTrap("")

READ PICTURE FILE:C678($sourcePath; $picturePtr->)

If (OK=1)
	
	//PICTURE PROPERTIES($picturePtr->;$iWidth;$iHeight)  //get to about 640x480
	//
	//If ($iWidth>480)
	//$rScale:=480/$iWidth
	//TRANSFORM PICTURE($picturePtr->;Scale;$rScale;$rScale)  //scale to 
	//End if 
	
	CONVERT PICTURE:C1002($picturePtr->; ".jpg"; 0.6)
	
Else 
	$0:=False:C215
End if 

endErrorTrap

//loadPicture