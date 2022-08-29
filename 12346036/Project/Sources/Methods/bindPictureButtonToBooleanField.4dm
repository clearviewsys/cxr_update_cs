//%attributes = {}
//bindPictureButtonToBooleanField(->picturebutton;->booleanField)
// use this method to bind a picture button to a boolean field
// FORM EVENTS: ON LOAD;  ON CLICKED

C_POINTER:C301($self; $fieldPtr; $1; $2)
$self:=$1
$fieldPtr:=$2

If (Form event code:C388=On Load:K2:1)
	$self->:=booleanToNum($fieldPtr->)
End if 

If (Form event code:C388=On Clicked:K2:4)
	$fieldPtr->:=numToBoolean($self->)
End if 

