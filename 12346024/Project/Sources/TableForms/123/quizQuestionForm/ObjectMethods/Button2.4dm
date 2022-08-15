var $testLog; $question : Object
var $isAnswerSelected : Boolean

$testLog:=ds:C1482.TestLog.new()
$testLog.testRunID:=Form:C1466.testRun.testRunID
$testLog.questionID:=Form:C1466.currentQuestion.questionID
$testLog.question:=Form:C1466.currentQuestion.question
$testLog.correctAnswer:=Form:C1466.currentQuestion.correctAnswer
$isAnswerSelected:=True:C214
Case of 
	: (Form:C1466.answer1Checkbox)
		$testLog.chosenAnswer:=Form:C1466.currentQuestion.answer1
		Form:C1466.answer1Checkbox:=False:C215
	: (Form:C1466.answer2Checkbox)
		$testLog.chosenAnswer:=Form:C1466.currentQuestion.answer2
		Form:C1466.answer2Checkbox:=False:C215
	: (Form:C1466.answer3Checkbox)
		$testLog.chosenAnswer:=Form:C1466.currentQuestion.answer3
		Form:C1466.answer3Checkbox:=False:C215
	: (Form:C1466.answer4Checkbox)
		$testLog.chosenAnswer:=Form:C1466.currentQuestion.answer4
		Form:C1466.answer4Checkbox:=False:C215
	Else 
		$isAnswerSelected:=False:C215
End case 

If ($isAnswerSelected)
	Form:C1466.testRunColl.push($testLog)
	If (Form:C1466.currentQuizQuestion.next()#Null:C1517)
		Form:C1466.currentQuizQuestion:=Form:C1466.currentQuizQuestion.next()
		Form:C1466.currentQuestion:=Form:C1466.currentQuizQuestion.question
		OBJECT SET VISIBLE:C603(previousButton; True:C214)
	End if 
	If (Form:C1466.currentQuizQuestion.next()=Null:C1517)
		For each ($question; Form:C1466.testRunColl)
			If ($question.correctAnswer=$question.chosenAnswer)
				Form:C1466.totalCorrectAnswers:=Form:C1466.totalCorrectAnswers+1
			End if 
			Form:C1466.totalQuestions:=Form:C1466.totalQuestions+1
			$question.save()
		End for each 
		Form:C1466.testRun.testResult:=Form:C1466.totalCorrectAnswers/Form:C1466.totalQuestions
		Form:C1466.testRun.creationDate:=Current date:C33(*)
		Form:C1466.testRun.save()
		myAlert("Quiz Finished, you answered "+String:C10(Form:C1466.totalCorrectAnswers)+" out of "+String:C10(Form:C1466.totalQuestions)+" questions correctly.")
	End if 
End if 

