//%attributes = {}
// colourizeObject (objectName; foreground;background)
C_TEXT:C284($object; $1)
C_LONGINT:C283($2; $3; $fore; $back)
$object:=$1
$fore:=$2
$back:=$3


// Modified by: Milan (12/3/2020)
// _O_OBJECT SET COLOR(*;$object;calcColour($fore;$back))
OBJECT SET RGB COLORS:C628(*; $object; convPalleteColourToRGB($fore); convPalleteColourToRGB($back))
