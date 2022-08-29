If (Form event code:C388=On Load:K2:1)
	var $quizId : Text
	$quizId:=[Quizzes:123]quizID:1
	Form:C1466.currentQuiz:=ds:C1482.Quizzes.query("quizID="+$quizId).first()
	If (Form:C1466.currentQuiz#Null:C1517)
		Form:C1466.questions:=Form:C1466.currentQuiz.quizQuestions.question
	End if 
End if 