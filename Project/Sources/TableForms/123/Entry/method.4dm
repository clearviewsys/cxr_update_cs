C_TEXT:C284($quizID)
C_OBJECT:C1216($quiz; $currQuizQuestion)

If (Form event code:C388=On Load:K2:1)
	Form:C1466.allQuestions:=New collection:C1472()
	Form:C1466.selectedQuestions:=New collection:C1472()
	
	If (Bool:C1537(Form:C1466.isCreateQuiz)=True:C214)
		Form:C1466.allQuestions:=ds:C1482.Questions.all().toCollection()
	Else 
		// Load up all questions from the current quiz
		Form:C1466.quizID:=[Quizzes:123]quizID:1
		$quiz:=ds:C1482.Quizzes.get(Form:C1466.quizID)
		Form:C1466.currQuizQuestions:=$quiz.quizQuestions.toCollection()
		Form:C1466.preEditQuizQuestionIDs:=New collection:C1472()
		For each ($currQuizQuestion; Form:C1466.currQuizQuestions)
			Form:C1466.preEditQuizQuestionIDs.push($currQuizQuestion.questionID)
		End for each 
		
		Form:C1466.quizName:=$quiz.quizName
		Form:C1466.selectedQuestions:=ds:C1482.Questions.query("questionID in :1"; Form:C1466.preEditQuizQuestionIDs).toCollection()
		Form:C1466.allQuestions:=ds:C1482.Questions.query("not (questionID in :1)"; Form:C1466.preEditQuizQuestionIDs).toCollection()
	End if 
End if 