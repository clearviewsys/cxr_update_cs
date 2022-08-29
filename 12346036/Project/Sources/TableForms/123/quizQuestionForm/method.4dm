If (Form event code:C388=On Load:K2:1)
	Form:C1466.allQuestion:=ds:C1482.QuizQuestions.all().query("quizID = :1"; Form:C1466.quiz.quizID)
	Form:C1466.currentQuizQuestion:=Form:C1466.allQuestion.first()
	Form:C1466.currentQuestion:=Form:C1466.currentQuizQuestion.question
	
	If (Form:C1466.currentQuizQuestion.next()#Null:C1517)
		OBJECT SET VISIBLE:C603(nextButton; True:C214)
		OBJECT SET VISIBLE:C603(finishButton; False:C215)
	Else 
		OBJECT SET VISIBLE:C603(nextButton; False:C215)
		OBJECT SET VISIBLE:C603(finishButton; True:C214)
	End if 
	
	If (Form:C1466.currentQuizQuestion.previous()#Null:C1517)
		OBJECT SET VISIBLE:C603(previousButton; True:C214)
	Else 
		OBJECT SET VISIBLE:C603(previousButton; False:C215)
	End if 
	
	Form:C1466.testRunColl:=New collection:C1472()
	Form:C1466.testRun:=ds:C1482.TestRun.new()
	Form:C1466.testRun.quizID:=Form:C1466.quiz.quizID
	Form:C1466.testRun.userID:=Form:C1466.userID
	
	Form:C1466.answer1Checkbox:=False:C215
	Form:C1466.answer2Checkbox:=False:C215
	Form:C1466.answer3Checkbox:=False:C215
	Form:C1466.answer4Checkbox:=False:C215
	
	Form:C1466.totalQuestions:=0
	Form:C1466.totalCorrectAnswers:=0
	
End if 
