//%attributes = {}
If (isUserAdministrator)
	displayLBox_(->[Quizzes:123])
Else 
	displayLBox_(->[Quizzes:123]; "QuizChoiceForm")
End if 
