//%attributes = {}
// clearPictureField (->field or var)

// this command delete a picture field from any content

C_POINTER:C301($1)
//C_BLOB($nilBlob)
//TEXT TO BLOB("";$nilBlob)
//BLOB TO PICTURE($nilBlob;$1->)
If (Not:C34(Is nil pointer:C315($1)))
	CLEAR VARIABLE:C89($1->)
End if 