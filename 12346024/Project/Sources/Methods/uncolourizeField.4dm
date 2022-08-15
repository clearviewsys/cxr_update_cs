//%attributes = {}
// uncolourize field (->field)
C_POINTER:C301($1)
C_LONGINT:C283($R; $G; $B; $RGB)
$R:=255
$G:=255
$B:=255

$RGB:=($R*256*256)+($G*256)+$B
OBJECT SET RGB COLORS:C628($1->; 127; $RGB)
