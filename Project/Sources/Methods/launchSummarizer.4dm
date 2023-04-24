//%attributes = {}
If (isUserAuthorizedToView(->[Registers:10]))
	//handleProcess (->[Forms];"launchSummarizer_M";False)
	C_LONGINT:C283($processNumber)
	$processNumber:=New process:C317("launchSummarizer_M"; 0; "Summarizer")
	
Else 
	myAlert("You are not authorized to view the registers in summarizer.")
End if 