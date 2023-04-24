//%attributes = {}
// SMS_notifyTiran ( message)
C_TEXT:C284($message; $1)

Case of 
	: (Count parameters:C259=1)
		$message:=$1
	Else 
		$message:="This is a notification sent from CurrencyXchanger "+getCurrentMachineName+" "+<>companyName
End case 


SMS_sendQuickMessageFromTiran("16047714328"; $message)
sendEmail("tiran@clearviewsys.com"; Substring:C12($message; 1; 50)+"..."; $message)

