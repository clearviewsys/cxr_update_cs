//%attributes = {}
// getRGBcomponents(rgbValue; ->red;->green;->rblue)
// this method returns the red, green, blue values 
C_LONGINT:C283($1)
C_POINTER:C301($2; $3; $4)

$2->:=maskRed($1)
$3->:=maskGreen($1)
$4->:=maskBlue($1)
