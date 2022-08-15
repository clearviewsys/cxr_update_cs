//%attributes = {}
C_TEXT:C284(vSubjectLine; vHeaderLine; vHelpRequest)
C_LONGINT:C283(cbUrgent)
C_LONGINT:C283($vError)

checkInit
checkAddWarningOnTrue(vHelpRequest=""; "You have not entered the reason for requesting help")
If (isValidationConfirmed)
	$vError:=sendEmail("support@clearviewsys.com"; vSubjectLine; vHeaderLine+CRLF+vHelpRequest)
	If (cbUrgent=1)
		SMS_sendQuickMessageFromTiran("16047714328"; vSubjectLine+" "+vHelpRequest)
	End if 
Else 
	REJECT:C38
End if 