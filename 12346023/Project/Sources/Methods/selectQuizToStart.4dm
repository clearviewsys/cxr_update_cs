//%attributes = {}
var $formObj; $quiz : Object
$formObj:=New object:C1471()
var $winRef : Integer

$winRef:=Open form window:C675([Quizzes:123]; "QuizChoiceForm"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40([Quizzes:123]; "QuizChoiceForm"; $formObj)