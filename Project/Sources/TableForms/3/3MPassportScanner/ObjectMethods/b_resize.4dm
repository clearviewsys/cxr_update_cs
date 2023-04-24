checkInit
C_LONGINT:C283($imageSize)
$imageSize:=Picture size:C356([Customers:3]PictureID_Image:53)/1000

checkAddWarningOnTrue($imageSize>250; "Size of image is larger than 250K")
checkAddWarningOnTrue($imageSize>500; "Size of image is larger than 500K")
checkAddWarningOnTrue($imageSize>1000; "Storing images larger than 1MB for a picture ID is not recommended")

If (isValidationConfirmed)
	
	ACCEPT:C269
End if 