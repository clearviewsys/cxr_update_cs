If (Form:C1466.currentItem#Null:C1517)
	createQuestion(Form:C1466.currentItem)
	Form:C1466.currentSelection:=ds:C1482.Questions.all()
Else 
	myAlert("Select a Question to Edit")
End if 