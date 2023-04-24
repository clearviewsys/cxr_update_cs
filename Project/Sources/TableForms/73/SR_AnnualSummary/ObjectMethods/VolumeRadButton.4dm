//making sure only one of the Count or Volume radio buttons can be selected
C_POINTER:C301($countRadioPtr; $volumeRadioPtr)
$countRadioPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "CountRadButton")
$volumeRadioPtr:=OBJECT Get pointer:C1124(Object current:K67:2)
If ($volumeRadioPtr->=1)
	$countRadioPtr->:=0
Else 
	$countRadioPtr->:=1
End if 