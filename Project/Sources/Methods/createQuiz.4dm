//%attributes = {}
var $formObj; $quiz; $reponse; $newQuestion; $quizQuestion; $question : Object
var $winRef : Integer
$formObj:=New object:C1471()
$newQuestion:=New object:C1471()
$formObj.isCreateQuiz:=True:C214

$winRef:=Open form window:C675([Quizzes:123]; "Entry"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40([Quizzes:123]; "Entry"; $formObj)
