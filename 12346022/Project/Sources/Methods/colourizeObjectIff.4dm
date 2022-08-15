//%attributes = {}
// colourizeObject (boolean; objectName; foreground;background)
C_BOOLEAN:C305($condition; $1)

C_TEXT:C284($object; $2)
C_LONGINT:C283($3; $4; $fore; $back)
$condition:=$1
$object:=$2
$fore:=$3
$back:=$4


// Modified by: Milan (12/3/2020)

If ($condition=True:C214)
	// _O_OBJECT SET COLOR(*;$object;calcColour($fore;$back))
	OBJECT SET RGB COLORS:C628(*; $object; convPalleteColourToRGB($fore); convPalleteColourToRGB($back))
Else 
	// _O_OBJECT SET COLOR(*;$object;calcColour(Black;White))
	OBJECT SET RGB COLORS:C628(*; $object; convPalleteColourToRGB(Black:K11:16); convPalleteColourToRGB(White:K11:1))
End if 