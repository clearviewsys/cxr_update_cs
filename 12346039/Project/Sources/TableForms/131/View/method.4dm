If (Form event code:C388=On Load:K2:1)
	If ([Questions:131]question:2#"")
		Form:C1466.currentItem:=ds:C1482.Questions.query("questionID="+[Questions:131]questionID:1).first()
	End if 
	Form:C1466.question:=Form:C1466.currentItem.question
	Form:C1466.answer1:=Form:C1466.currentItem.answer1
	Form:C1466.answer2:=Form:C1466.currentItem.answer2
	Form:C1466.answer3:=Form:C1466.currentItem.answer3
	Form:C1466.answer4:=Form:C1466.currentItem.answer4
	
	If (Form:C1466.currentItem.answer1=Form:C1466.currentItem.correctAnswer)
		Form:C1466.answer1Checkbox:=True:C214
	End if 
	If (Form:C1466.currentItem.answer2=Form:C1466.currentItem.correctAnswer)
		Form:C1466.answer2Checkbox:=True:C214
	End if 
	If (Form:C1466.currentItem.answer3=Form:C1466.currentItem.correctAnswer)
		Form:C1466.answer3Checkbox:=True:C214
	End if 
	If (Form:C1466.currentItem.answer4=Form:C1466.currentItem.correctAnswer)
		Form:C1466.answer4Checkbox:=True:C214
	End if 
Else 
	
End if 


