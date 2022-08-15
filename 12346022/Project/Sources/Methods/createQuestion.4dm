//%attributes = {}
var $formObj; $newQuestion; $reponse : Object
var $1 : Text
var $winRef : Integer

$formObj:=New object:C1471()
$newQuestion:=New object:C1471()

Case of 
	: (Count parameters:C259=1)
		$formObj.currentItem:=$1
		$formObj.isEdit:=True:C214
	Else 
		$formObj.isEdit:=False:C215
End case 


//Open form to create new question
$winRef:=Open form window:C675([Questions:131]; "Entry"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40([Questions:131]; "Entry"; $formObj)

If (OK=1)
	// Save question from information in Form Object
	If ($formObj.isEdit)
		$newQuestion:=ds:C1482.Questions.query("questionID="+$formObj.currentItem.questionID).first()
	Else 
		$newQuestion:=ds:C1482.Questions.new()
	End if 
	$newQuestion.question:=$formObj.question
	$newQuestion.answer1:=$formObj.answer1
	$newQuestion.answer2:=$formObj.answer2
	$newQuestion.answer3:=$formObj.answer3
	$newQuestion.answer4:=$formObj.answer4
	
	Case of 
		: ($formObj.answer1Checkbox)
			$newQuestion.correctAnswer:=$formObj.answer1
		: ($formObj.answer2Checkbox)
			$newQuestion.correctAnswer:=$formObj.answer2
		: ($formObj.answer3Checkbox)
			$newQuestion.correctAnswer:=$formObj.answer3
		: ($formObj.answer4Checkbox)
			$newQuestion.correctAnswer:=$formObj.answer4
	End case 
	
	$reponse:=$newQuestion.save()
	
	If ($reponse.success)
		myAlert("Question Sucessfully Saved")
	Else 
		myAlert("There was an issue saving your question")
	End if 
End if 