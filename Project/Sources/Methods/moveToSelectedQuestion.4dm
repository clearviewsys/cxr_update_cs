//%attributes = {}
If (Form:C1466.currentItemAllQuestions#Null:C1517)
	Form:C1466.selectedQuestions.push(Form:C1466.currentItemAllQuestions)
	Form:C1466.currentSubSelection:=Form:C1466.allQuestions.query("questionID # :1"; Form:C1466.currentItemAllQuestions.questionID)
	Form:C1466.allQuestions:=Form:C1466.currentSubSelection
End if 
