If (Form event code:C388=On Double Clicked:K2:5)
	If (Form:C1466.question#Null:C1517)
		createQuestion(Form:C1466.question)
	End if 
End if 
Form:C1466.currentSelectionQuizzes:=ds:C1482.Quizzes.all()