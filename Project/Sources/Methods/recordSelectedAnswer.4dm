//%attributes = {}
var $testLog : Object
var $isAnswerChosen : Boolean

$testLog:=ds:C1482.TestLog.new()
$testLog.questionID:=Form:C1466.currentQuestion.questionID
$testLog.question:=Form:C1466.currentQuestion.question
$testLog.correctAnswer:=Form:C1466.currentQuestion.correctAnswer
$isAnswerChosen:=True:C214
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
		$isAnswerChosen:=False:C215
End case 

If ($isAnswerChosen)
	Form:C1466.testRun.push($testLog)
End if 

$0:=$isAnswerChosen
