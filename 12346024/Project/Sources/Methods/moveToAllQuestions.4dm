//%attributes = {}
If (Form:C1466.currentItemSelectedQuestions#Null:C1517)
	Form:C1466.allQuestions:=Form:C1466.allQuestions.push(Form:C1466.currentItemSelectedQuestions)
	Form:C1466.currentSubSelection:=Form:C1466.selectedQuestions.query("questionID # :1"; Form:C1466.currentItemSelectedQuestions.questionID)
	Form:C1466.selectedQuestions:=Form:C1466.currentSubSelection
End if 