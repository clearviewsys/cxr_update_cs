//%attributes = {}
checkUniqueKey(->[PictureIDTypes:92]; ->[PictureIDTypes:92]TemplateID:1; "Picture ID Code")
checkIfNullString(->[PictureIDTypes:92]PictureIDType:5; "Type of Picture ID")
checkIfNullString(->[PictureIDTypes:92]Description:14; "Description")

If ([PictureIDTypes:92]MinLength:12>[PictureIDTypes:92]MaxLength:21)
	checkAddError("Min Length should be less than or equal to maximum length")
End if 

If ([PictureIDTypes:92]MinLength:12<4)
	checkAddWarning("Most Picture IDs numbers are longer than 4 characters")
End if 

If ([PictureIDTypes:92]MinLength:12=0)
	checkAddError("Min Length cannot be 0")
End if 


