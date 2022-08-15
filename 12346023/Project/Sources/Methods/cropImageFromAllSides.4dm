//%attributes = {}
C_POINTER:C301($picturePtr; $1)
C_REAL:C285($cropProportion; $2)

Case of 
	: (Count parameters:C259=1)
		$picturePtr:=$1
		$cropProportion:=0.03
		
	: (Count parameters:C259=2)
		$picturePtr:=$1
		$cropProportion:=$2
		
	Else 
		
End case 


C_LONGINT:C283($iWidth; $iHeight; $cropValue)

PICTURE PROPERTIES:C457($picturePtr->; $iWidth; $iHeight)  //get to about 640x480

$cropValue:=Int:C8($iWidth*$cropProportion)  // by crop by 3 percent

C_PICTURE:C286(vPreviousPicture)
vPreviousPicture:=$picturePtr->

TRANSFORM PICTURE:C988($picturePtr->; Crop:K61:7; $cropValue; $cropValue; $iWidth-$cropValue-$cropValue; $iHeight-$cropValue-$cropValue)  //scale to 
CONVERT PICTURE:C1002($picturePtr->; ".jpg"; 0.6)
