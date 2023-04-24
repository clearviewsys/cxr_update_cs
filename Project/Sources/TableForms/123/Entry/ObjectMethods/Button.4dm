var $quiz; $question; $quizQuestion : Object

Case of 
	: (String:C10(Form:C1466.quizName)="")
		ALERT:C41("Name cannot be blank")
	: (Form:C1466.selectedQuestions.length<1)
		ALERT:C41("Please select one or more questions for this quiz")
	Else 
		
		$quiz:=New object:C1471()
		If (Bool:C1537(Form:C1466.isCreateQuiz)=False:C215)
			ds:C1482.QuizQuestions.query("quizID= :1"; Form:C1466.quizID).drop()
			$quiz.quizID:=Form:C1466.quizID
			If ([Quizzes:123]quizName:2#Form:C1466.quizName)
				[Quizzes:123]quizName:2:=Form:C1466.quizName
			End if 
		Else 
			$quiz:=ds:C1482.Quizzes.new()
			$quiz.quizName:=Form:C1466.quizName
			$quiz.creationDate:=Current date:C33(*)
			$quiz.save()
		End if 
		
		For each ($question; Form:C1466.selectedQuestions)
			$quizQuestion:=New object:C1471()
			$quizQuestion:=ds:C1482.QuizQuestions.new()
			$quizQuestion.quizID:=$quiz.quizID
			$quizQuestion.questionID:=$question.questionID
			$quizQuestion.save()
		End for each 
		
		ACCEPT:C269
End case 