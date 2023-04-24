//%attributes = {}
If ([BankNotes:23]CatNo:3#0)
	C_PICTURE:C286(vPictObverse; vPictReverse)
	//If (Current form page=1)

	//vPictObverse:=fetchBankNotePicture (True)

	//clearPictureField (->vPictReverse)

	//Else 

	//vPictReverse:=fetchBankNotePicture (False)

	//clearPictureField (->vPictObverse)

	//End if 

	vPictObverse:=fetchBankNotePicture(True:C214)
	vPictReverse:=fetchBankNotePicture(False:C215)
End if 