var $quiz; $question; $quizQuestion : Object

Case of 
	: (String:C10(Form:C1466.quizName)="")
		ALERT:C41("Name cannot be blank")
	: (Form:C1466.selectedQuestions.length<1)
		ALERT:C41("Please select one or more questions for this quiz")
	Else 
		ACCEPT:C269
End case 