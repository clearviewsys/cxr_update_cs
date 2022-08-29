If (Form event code:C388=On Clicked:K2:4)
	If (Shift down:C543)
		loadPicture(""; Self:C308)
	End if 
End if 

If (Form event code:C388=On Double Clicked:K2:5)
	// enlargePicture
	showEnlargedPicture(Self:C308->)
End if 