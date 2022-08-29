var $hasEmptyField : Boolean
$hasEmptyField:=(String:C10([Questions:131]question:2)="") | (String:C10([Questions:131]answer1:3)="") | (String:C10([Questions:131]answer2:4)="") | (String:C10([Questions:131]answer3:5)="") | (String:C10([Questions:131]answer4:6)="")
If ($hasEmptyField)
	myAlert("Please fill in all the feild before proceeding")
Else 
	Case of 
		: (Form:C1466.answer1Checkbox)
			[Questions:131]correctAnswer:7:=[Questions:131]answer1:3
		: (Form:C1466.answer2Checkbox)
			[Questions:131]correctAnswer:7:=[Questions:131]answer2:4
		: (Form:C1466.answer3Checkbox)
			[Questions:131]correctAnswer:7:=[Questions:131]answer3:5
		: (Form:C1466.answer4Checkbox)
			[Questions:131]correctAnswer:7:=[Questions:131]answer4:6
	End case 
	ACCEPT:C269
End if 
