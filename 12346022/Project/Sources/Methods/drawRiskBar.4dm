//%attributes = {}
// drawRiskBar (objectName; riskRating)

C_TEXT:C284($svg; $bar)
C_PICTURE:C286($pict)
C_TEXT:C284($objectName; $1)
C_LONGINT:C283($rating; $2)

Case of 
	: (Count parameters:C259=0)
		$objectName:="map"
		$rating:=1
		
	: (Count parameters:C259=2)
		$objectName:=$1
		$rating:=$2
End case 
C_LONGINT:C283($w; $h; $r)
$w:=100
$h:=40
$r:=0

$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $objectName)

C_POINTER:C301($ptr)
$svg:=SVG_New($w; $h; "Bar"; "Description"; True:C214; Scaled to fit:K6:2)
//SVG_New_rect ( parentSVGObject ; x ; y ; width ; height {; roundedX {; roundedY {; foregroundColor {; backgroundColor {; strokeWidth}}}}} ) -> Function result 
Case of 
	: ($rating=0)
		$bar:=SVG_New_rect($svg; 0; 0; 0; $h; $r; $r; "black"; "black"; 1)
	: ($rating=1)
		$bar:=SVG_New_rect($svg; 0; 0; 20; $h; $r; $r; "lightgreen"; "lightgreen"; 1)
	: ($rating=2)
		$bar:=SVG_New_rect($svg; 0; 0; 40; $h; $r; $r; "cornflowerblue"; "cornflowerblue"; 1)
	: ($rating=3)
		$bar:=SVG_New_rect($svg; 0; 0; 60; $h; $r; $r; "orange"; "orange"; 1)
	: ($rating=4)
		$bar:=SVG_New_rect($svg; 0; 0; 80; $h; $r; $r; "red"; "red"; 1)
	: ($rating=5)
		$bar:=SVG_New_rect($svg; 0; 0; 100; $h; $r; $r; "crimson"; "crimson"; 1)
End case 

SVG EXPORT TO PICTURE:C1017($svg; $pict)
$ptr->:=$pict

SVG_CLEAR($svg)

