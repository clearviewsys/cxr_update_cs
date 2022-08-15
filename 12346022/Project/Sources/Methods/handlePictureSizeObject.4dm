//%attributes = {}
// handlePictureSizeObject (->pictureField)
// this method update the object called pictureSizeInKB
C_POINTER:C301($self; $1)
C_REAL:C285($size)
C_TEXT:C284($objectName)
$objectName:="pictureSizeInKB"
Case of 
	: (Count parameters:C259=0)
		$self:=Self:C308
	: (Count parameters:C259=1)
		$self:=$1
	Else 
		assertInvalidNumberOfParams
End case 

$size:=Picture size:C356($self->)\1024
OBJECT SET TITLE:C194(*; $objectName; String:C10($size)+" KB")


// Modified by: Milan (12/3/2020)
If ($size>=300)
	// _O_OBJECT SET COLOR(*;$objectName;-(Red+(256*White)))
	OBJECT SET RGB COLORS:C628(*; $objectName; convPalleteColourToRGB(Red:K11:4); convPalleteColourToRGB(White:K11:1))
Else 
	// _O_OBJECT SET COLOR(*;$objectName;-(Black+(256*White)))
	OBJECT SET RGB COLORS:C628(*; $objectName; convPalleteColourToRGB(Black:K11:16); convPalleteColourToRGB(White:K11:1))
End if 