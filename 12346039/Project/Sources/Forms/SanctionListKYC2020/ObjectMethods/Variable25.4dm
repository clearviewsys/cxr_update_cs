If (Form event code:C388=On Clicked:K2:4)
	If (Form:C1466.selectedArticle["guid"]="http@")
		OPEN URL:C673(Form:C1466.selectedArticle["guid"])
	End if 
End if 