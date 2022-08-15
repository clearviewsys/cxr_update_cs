handleViewFormMethod
If (Form event code:C388=On Load:K2:1)
	C_PICTURE:C286(vPictObverse; vPictReverse)
	clearPictureField(->vPictObverse)
	clearPictureField(->vPictReverse)
	
	handleDownloadBankNote
End if 

If (Form event code:C388=On Outside Call:K2:11)
	//handleDownloadBankNote 
End if 