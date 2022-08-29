//%attributes = {}
C_LONGINT:C283(errorCode)
C_TEXT:C284(CallerMethod; CallerErrorMessage)

errorCode:=Error
If (CallerErrorMessage#"")
	notifyAlert("Error"; CallerErrorMessage+". Error Code:"+String:C10(errorCode); 10)  // changed Jun 15 /2020 #TB #testit
End if 