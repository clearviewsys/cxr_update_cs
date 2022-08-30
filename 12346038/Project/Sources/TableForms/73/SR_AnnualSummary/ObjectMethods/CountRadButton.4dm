//making sure only one of the Count or Volume radio buttons can be selected
C_POINTER:C301($countRadioPtr; $volumeRadioPtr)
$countRadioPtr:=OBJECT Get pointer:C1124(Object current:K67:2)
$volumeRadioPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "VolumeRadButton")
If ($countRadioPtr->=1)
	$volumeRadioPtr->:=0
Else 
	$volumeRadioPtr->:=1
End if 