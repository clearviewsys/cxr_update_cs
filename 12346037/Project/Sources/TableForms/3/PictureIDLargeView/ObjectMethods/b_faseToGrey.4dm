C_LONGINT:C283($iWidth; $iHeight)
C_REAL:C285($rScale)
$rScale:=0.9

PICTURE PROPERTIES:C457([Customers:3]PictureID_Image:53; $iWidth; $iHeight)  //get to about 640x480

TRANSFORM PICTURE:C988([Customers:3]PictureID_Image:53; Fade to grey scale:K61:6)
CONVERT PICTURE:C1002([Customers:3]PictureID_Image:53; ".jpg"; 0.6)
