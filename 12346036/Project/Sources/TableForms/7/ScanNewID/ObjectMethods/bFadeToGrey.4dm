C_LONGINT:C283($iWidth; $iHeight)
C_REAL:C285($rScale)
$rScale:=0.9

PICTURE PROPERTIES:C457(docPhoto2; $iWidth; $iHeight)  //get to about 640x480

TRANSFORM PICTURE:C988(docPhoto2; Fade to grey scale:K61:6)
CONVERT PICTURE:C1002(docPhoto2; ".jpg"; 0.6)
