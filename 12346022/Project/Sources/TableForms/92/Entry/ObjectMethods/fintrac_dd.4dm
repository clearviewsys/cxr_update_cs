C_TEXT:C284($selection)
$selection:=Self:C308->{Self:C308->}
If ($selection#"")
	[PictureIDTypes:92]GovernmentCode:15:=Substring:C12($selection; 1; 1)
	[PictureIDTypes:92]PictureIDType:5:=Substring:C12($selection; 3)
End if 
