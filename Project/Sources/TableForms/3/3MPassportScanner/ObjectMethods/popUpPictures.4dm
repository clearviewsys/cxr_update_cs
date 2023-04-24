//If (Form event=On Load )
//DOCUMENT LIST(getClientPictureIDSource ;arrPictures)
//INSERT ELEMENT(arrPictures;1)
//arrPictures{1}:="Refresh List..."
//End if 

If (Form event code:C388=On Clicked:K2:4)
	C_TEXT:C284($tPathName)
	$tPathName:=getClientPictureIDSource
	If (Test path name:C476($tPathName)=Is a folder:K24:2)
		If (arrPictures=1)  // refresh
			DOCUMENT LIST:C474($tPathName; arrPictures)
			INSERT IN ARRAY:C227(arrPictures; 1)
			arrPictures{1}:="Refresh List..."
		Else 
			loadPicture($tPathName+arrPictures{arrPictures}; ->[Customers:3]PictureID_Image:53)
		End if 
	End if 
End if 