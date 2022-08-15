//%attributes = {}
// setRGBColourBG (object)
// chang ethe background colour of an obje.t
C_TEXT:C284($1)
C_LONGINT:C283($r; $g; $b)
$r:=220
$g:=230
$b:=255

OBJECT SET RGB COLORS:C628(*; $1; 127; ($R*256*256)+($g*256)+$B)
