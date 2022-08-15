//%attributes = {}
// setFieldRGBColour (->obj; f_red;f_green;f_blue;b_red;b_green;b_blue)

C_POINTER:C301($1; $fieldPtr)
$fieldPtr:=$1

C_LONGINT:C283($FGred; $FGgreen; $FGblue; $FGrgb; $2; $3; $4)
C_LONGINT:C283($BGred; $BGgreen; $BGblue; $BGrgb; $3; $4; $5)

$FGred:=$3
$FGgreen:=$4
$FGblue:=$5

$FGred:=$3
$FGgreen:=$4
$FGblue:=$5

$FGRGB:=($FGRed*256*256)+($FGgreen*256)+$FGBlue
$BGRGB:=($BGRed*256*256)+($BGgreen*256)+$BGBlue

OBJECT SET RGB COLORS:C628($1->; $FGRGB; $BGRGB; 65536-$BGRGB)
