//%attributes = {}
// setStampStyle (style; textColour; stroke;size; x; y ;$font;opacity)
C_OBJECT:C1216($style; $1)
C_TEXT:C284($textColour; $2)
C_LONGINT:C283($stroke; $3)
C_LONGINT:C283($size; $4)
C_LONGINT:C283($x; $5)
C_LONGINT:C283($y; $6)
C_TEXT:C284($font; $7)
C_LONGINT:C283($opacity; $8)

$style:=$1
$textColour:="red"
$size:=36
$font:="Tahoma"
$opacity:=80
$x:=5
$y:=5
$stroke:=3

Case of 
	: (Count parameters:C259=1)
		
	: (Count parameters:C259=3)
		$textColour:=$2
		$stroke:=$3
		
	: (Count parameters:C259=4)
		$textColour:=$2
		$stroke:=$3
		$size:=$4
		
	: (Count parameters:C259=8)
		
		$style:=$1
		$textColour:=$2
		$stroke:=$3
		$size:=$4
		$x:=$5
		$y:=$6
		$font:=$7
		$opacity:=$8
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$style.textColour:=$textColour
$style.stroke:=$stroke
$style.size:=$size
$style.x:=$x
$style.y:=$y
$style.font:=$font
$style.opacity:=$opacity

