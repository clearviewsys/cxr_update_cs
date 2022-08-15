//GOTO OBJECT(*;"vAmount")
//inv_setAmount (vAmount*1000)

C_POINTER:C301($vAmountLocalPtr; $vAmountPtr; $widgetPtr)
$vAmountPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "vAmount")
$vAmountLocalPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "vAmountLocal")

$widgetPtr:=OBJECT Get pointer:C1124(Object with focus:K67:3)
If (($widgetPtr=$vAmountPtr) | ($widgetPtr=$vAmountLocalPtr))  // only for these two fields
	$widgetPtr->:=($widgetPtr->)*1000  // multiply the field by 1000
	//GOTO OBJECT(*;$widgetPtr->)
	
End if 