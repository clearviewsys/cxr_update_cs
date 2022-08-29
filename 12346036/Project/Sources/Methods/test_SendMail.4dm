//%attributes = {}
C_TEXT:C284($host; $toAddress; $fromAddress; $subject; $message)
C_LONGINT:C283($error)


$Host:="smtp2go.com"
$ToAddress:="tiran@me.com"
$FromAddress:="support@clearviewsys.com"
$Subject:="Testing SMTP2Go"
$Message:="Does this smtp2go thing really work?."
$Error:=SMTP_QuickSend($Host; $FromAddress; $ToAddress; $Subject; $Message)
If ($Error#0)
	myAlert("Error:  SMTP_QuickSend"+Char:C90(13)+IT_ErrorText($Error))
End if 
