//%attributes = {}
// moveImage (->image; xVector; yVector)
// POST: will reduce the size and quality of the image after translation


C_POINTER:C301($picturePtr; $1)
C_REAL:C285($XVector; $yVector; $2; $3)

$picturePtr:=$1
$XVector:=$2
$yVector:=$3

C_LONGINT:C283($iWidth; $iHeight; $xTrans; $yTrans)

PICTURE PROPERTIES:C457($picturePtr->; $iWidth; $iHeight)  //get to about 640x480

$xTrans:=Int:C8($iWidth*0.05)  // by crop by 3 percent
$yTrans:=Int:C8($iHeight*0.05)  // by crop by 3 percent



C_PICTURE:C286(vPreviousPicture)
vPreviousPicture:=$picturePtr->

TRANSFORM PICTURE:C988($picturePtr->; Translate:K61:3; $XVector*$xTrans; $yVector*$yTrans)
CONVERT PICTURE:C1002($picturePtr->; ".jpg"; 0.6)
