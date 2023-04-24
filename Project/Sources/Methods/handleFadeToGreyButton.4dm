//%attributes = {}
// handleFadeToGreyButton (->picture)

C_LONGINT:C283($iWidth; $iHeight)
C_REAL:C285($rScale)
$rScale:=0.9
C_POINTER:C301($picturePtr; $1)

Case of 
	: (Count parameters:C259=1)
		$picturePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


PICTURE PROPERTIES:C457($picturePtr->; $iWidth; $iHeight)  //get to about 640x480

TRANSFORM PICTURE:C988($picturePtr->; Fade to grey scale:K61:6)
CONVERT PICTURE:C1002($picturePtr->; ".jpg"; 0.6)

