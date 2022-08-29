var $winRef : Integer
var $formObj : Object

If (Form event code:C388=On Double Clicked:K2:5)
	If (Form:C1466.question#Null:C1517)
		$formObj:=New object:C1471()
		$formObj.currentItem:=New object:C1471()
		$formObj.currentItem.question:=Form:C1466.question.question
		$formObj.currentItem.answer1:=Form:C1466.question.answer1
		$formObj.currentItem.answer2:=Form:C1466.question.answer2
		$formObj.currentItem.answer3:=Form:C1466.question.answer3
		$formObj.currentItem.answer4:=Form:C1466.question.answer4
		$formObj.currentItem.correctAnswer:=Form:C1466.question.correctAnswer
		$formObj.isQuizPreview:=True:C214
		$winRef:=Open form window:C675([Questions:131]; "View"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40([Questions:131]; "View"; $formObj)
	End if 
End if 