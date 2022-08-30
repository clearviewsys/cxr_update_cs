C_TEXT:C284($selection)
$selection:=Self:C308->{Self:C308->}
If ($selection#"")
	[PictureIDTypes:92]GovernmentCode:15:=Substring:C12($selection; 1; 1)
	[PictureIDTypes:92]Description:14:=Substring:C12($selection; 5)
	
End if 
