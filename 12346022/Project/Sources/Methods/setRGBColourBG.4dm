//%attributes = {}
// setRGBColourBG (object;R;G;B)
// chang ethe background colour of an obje.t
C_TEXT:C284($1)
C_LONGINT:C283($4; $2; $3; $r; $g; $b)
$r:=$2
$g:=$3
$b:=$4

OBJECT SET RGB COLORS:C628(*; $1; 127; ($R*256*256)+($g*256)+$B)
