//%attributes = {}
// setRGBColourBG (object)
// chang ethe background colour of an obje.t
C_TEXT:C284($1)
C_LONGINT:C283($r; $g; $b)
$r:=255
$g:=255
$b:=200

OBJECT SET RGB COLORS:C628(*; $1; 127; ($R*256*256)+($g*256)+$B)
