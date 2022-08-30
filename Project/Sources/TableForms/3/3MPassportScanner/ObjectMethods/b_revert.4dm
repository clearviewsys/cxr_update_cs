C_PICTURE:C286(vLoadedPicture)

[Customers:3]PictureID_Image:53:=Old:C35([Customers:3]PictureID_Image:53)
If (Picture size:C356([Customers:3]PictureID_Image:53)=0)
	[Customers:3]PictureID_Image:53:=vLoadedPicture
End if 