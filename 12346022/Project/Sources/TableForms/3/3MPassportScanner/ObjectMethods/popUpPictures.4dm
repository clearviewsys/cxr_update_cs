//If (Form event=On Load )
//DOCUMENT LIST(getClientPictureIDSource ;arrPictures)
//INSERT ELEMENT(arrPictures;1)
//arrPictures{1}:="Refresh List..."
//End if 

If (Form event code:C388=On Clicked:K2:4)
	If (arrPictures=1)  // refresh
		DOCUMENT LIST:C474(getClientPictureIDSource; arrPictures)
		INSERT IN ARRAY:C227(arrPictures; 1)
		arrPictures{1}:="Refresh List..."
	Else 
		loadPicture(getClientPictureIDSource+arrPictures{arrPictures}; ->[Customers:3]PictureID_Image:53)
	End if 
	
	
	
End if 