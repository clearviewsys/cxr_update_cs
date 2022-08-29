If (Form event code:C388=On Double Clicked:K2:5)
	If (Form:C1466.currentItem#Null:C1517)
		createQuestion(Form:C1466.currentItem)
		Form:C1466.currentSelection:=ds:C1482.Questions.all()
	End if 
End if 