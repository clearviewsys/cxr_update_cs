//%attributes = {}
// stampText (objectName; text; colour; ifTrue:boolean; styleObj)
// This method uses SVG to write a banner style text. it needs a picture object

C_PICTURE:C286($pic)
C_POINTER:C301($picPtr)
C_TEXT:C284($text; $2; $objectName; $1; $textColour; $3)
C_BOOLEAN:C305($ifTrue; $4)
C_OBJECT:C1216($style; $5)

$style:=New object:C1471
$style.textColour:="red"
$style.size:=36
$style.font:="Tahoma"
$style.opacity:=80
$style.x:=5
$style.y:=5
$style.stroke:=3

$text:="ON HOLD"
$objectName:="picture"
$textColour:=$style.textColour
$ifTrue:=True:C214

Case of 
	: (Count parameters:C259=0)
		
	: (Count parameters:C259=1)
		$objectName:=$1
		
	: (Count parameters:C259=2)
		$objectName:=$1
		$text:=$2
		
	: (Count parameters:C259=3)
		$objectName:=$1
		$text:=$2
		$textColour:=$3
		
	: (Count parameters:C259=4)
		$objectName:=$1
		$text:=$2
		$textColour:=$3
		$ifTrue:=$4
		
	: (Count parameters:C259=5)
		$objectName:=$1
		$text:=$2
		$textColour:=$3
		$ifTrue:=$4
		$style:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($textColour#"")
	$style.textColour:=$textColour
End if 


$picPtr:=OBJECT Get pointer:C1124(Object named:K67:5; $objectName)

If ($ifTrue)
	If (Not:C34(Is nil pointer:C315($picPtr)))
		C_LONGINT:C283($left; $right; $top; $bottom; $width; $heigth; $pad)
		
		OBJECT GET COORDINATES:C663(*; $objectName; $left; $top; $right; $bottom)
		$width:=$right-$left
		$heigth:=$bottom-$top
		
		If ($style.size*Length:C16($text)>($width*0.9))  // text won't fit
			C_REAL:C285($ratio)
			$ratio:=$width/Length:C16($text)
			$style.size:=Int:C8($ratio)*1.35
		End if 
		C_TEXT:C284($svgRef; $textSVG; $rectSVG)
		
		$svgRef:=SVG_New
		$pad:=4
		
		If ($text#"")
			$rectSVG:=SVG_New_rect($svgRef; $pad; $pad; $width-($pad << 1); $heigth-($pad << 1); 15; 15; $textColour; "white"; $style.stroke)
			SVG_SET_OPACITY($rectSVG; 60; 80)
		End if 
		
		$textSVG:=SVG_New_text($svgRef; $text; $width >> 1; ($heigth-$style.size) >> 1-$pad; $style.font; $style.size; Bold:K14:2; Align center:K42:3)
		SVG_SET_OPACITY($textSVG; $style.opacity; $style.opacity)
		
		SVG_SET_FONT_COLOR($textSVG; $style.textColour)
		//SVG_SET_DIMENSIONS($textSVG;($right-$left);($bottom-$top);"px")// scale the text? 
		$pic:=SVG_Export_to_picture($svgRef)
		$picPtr->:=$pic
		
		SVG_CLEAR($svgRef)  // release memory
		
	End if 
	
Else 
	If (Not:C34(Is nil pointer:C315($picPtr)))
		$picPtr->:=$pic
	End if 
End if 