//%attributes = {}
var $formObj; $quiz : Object
$formObj:=New object:C1471()
var $winRef : Integer


Case of 
	: (Count parameters:C259=1)
		$formObj:=$1
	Else 
		
End case 

$winRef:=Open form window:C675([Quizzes:123]; "quizQuestionForm"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40([Quizzes:123]; "quizQuestionForm"; $formObj)