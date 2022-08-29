C_POINTER:C301($picPtr)
C_OBJECT:C1216($style)

$style:=New object:C1471

$style.font:="Verdana"
$style.size:=40
$style.opacity:=20
$style.textColour:="red"
$style.stroke:=1

stampText("onHold"; "Suspicious"; "red"; True:C214; $style)
