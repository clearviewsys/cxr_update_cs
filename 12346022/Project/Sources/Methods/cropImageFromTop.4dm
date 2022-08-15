//%attributes = {}
C_POINTER:C301($picturePtr; $1)

$picturePtr:=$1

C_LONGINT:C283($iWidth; $iHeight; $cropValue)

PICTURE PROPERTIES:C457($picturePtr->; $iWidth; $iHeight)  //get to about 640x480
If (Shift down:C543)
	$cropValue:=Int:C8($iHeight*0.1)  // by crop by 10 percent
Else 
	$cropValue:=Int:C8($iHeight*0.03)  // by crop by 3 percent
End if 

C_PICTURE:C286(vPreviousPicture)
vPreviousPicture:=$picturePtr->

TRANSFORM PICTURE:C988($picturePtr->; Crop:K61:7; 0; $cropValue; $iWidth; $iHeight-$cropValue)  //scale to 
CONVERT PICTURE:C1002($picturePtr->; ".jpg"; 0.6)
POST OUTSIDE CALL:C329(Current process:C322)