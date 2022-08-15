If (Form event code:C388=On Clicked:K2:4)
	//GOTO OBJECT(*;"bSaveAndConfirm")
	If (([Customers:3]PictureID_Number:69="") | ([Customers:3]PictureID_TemplateID:15=""))
		BEEP:C151
		myAlert("You need to enter the Picture ID info")
		Self:C308->:=0
		GOTO OBJECT:C206(*; "MainPictureID")
	Else 
		//GOTO OBJECT(*;"bSaveAndConfirm")
	End if 
	
End if 