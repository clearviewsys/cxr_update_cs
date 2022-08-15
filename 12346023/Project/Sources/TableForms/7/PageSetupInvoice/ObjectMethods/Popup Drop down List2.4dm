
If (Form event code:C388=On Load:K2:1)
	arrPageOptions:=Find in array:C230(arrPageOptions; <>lastPageOption)
	
End if 


If (Form event code:C388=On Clicked:K2:4)
	<>lastPageOption:=arrPageOptions{arrPageOptions}
End if 