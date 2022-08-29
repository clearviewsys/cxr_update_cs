var $formObj : Object
var $vlProcessID : Integer
$formObj:=New object:C1471()
$formObj.userID:=<>UserID
If (OB Get type:C1230(Form:C1466; "selectedQuiz")=Is object:K8:27)
	$formObj.quiz:=Form:C1466.selectedQuiz.toObject()
	$vlProcessID:=New process:C317("startQuiz"; 0; "startQuiz"; $formObj)
	ACCEPT:C269
Else 
	ALERT:C41("Please Select a Quiz to Start")
End if 
