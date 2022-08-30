If (Form event code:C388=On Clicked:K2:4)
	If (Form:C1466.currentQuiz#Null:C1517)
		Form:C1466.questions:=Form:C1466.currentQuiz.quizQuestions.question
	End if 
End if 