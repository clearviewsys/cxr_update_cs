//%attributes = {}
var $formObj; $quiz; $reponse; $newQuestion; $quizQuestion; $question : Object
var $winRef : Integer
$formObj:=New object:C1471()
$newQuestion:=New object:C1471()

$winRef:=Open form window:C675([Quizzes:123]; "Entry"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40([Quizzes:123]; "Entry"; $formObj)

If (OK=1)
	$quiz:=New object:C1471()
	$quiz:=ds:C1482.Quizzes.new()
	$quiz.quizName:=$formObj.quizName
	$quiz.creationDate:=Current date:C33(*)
	$quiz.save()
	
	For each ($question; $formObj.selectedQuestions)
		$quizQuestion:=New object:C1471()
		$quizQuestion:=ds:C1482.QuizQuestions.new()
		$quizQuestion.quizID:=$quiz.quizID
		$quizQuestion.questionID:=$question.questionID
		$quizQuestion.save()
	End for each 
End if 