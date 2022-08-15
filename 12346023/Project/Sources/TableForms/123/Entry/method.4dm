If (Form event code:C388=On Load:K2:1)
	Form:C1466.allQuestions:=New collection:C1472()
	Form:C1466.selectedQuestions:=New collection:C1472()
	//If (Form.isEdit)
	//$quizID:=[Quizzes]quizID
	//$currQuiz:=ds.Quizzes.query("quizID="+$quizID).first()
	//Form.quizName:=$currQuiz.quizName
	//Form.quizID:=$currQuiz.quizID
	//$currQuizQuestions:=$currQuiz.quizQuestions.toCollection()
	//$allQuiestions:=ds.Questions.all().toCollection()
	//For each ($question; $currQuizQuestions)
	//$entity:=$allQuiestions.query("questionID="+$question.questionID)[0]
	//Form.selectedQuestions.push($entity)
	//$index:=$allQuiestions.indexOf($entity)
	//$allQuiestions.remove($index)
	//End for each 
	//Form.allQuestions:=$allQuiestions
	//Else 
	Form:C1466.allQuestions:=ds:C1482.Questions.all().toCollection()
End if 
//End if 
