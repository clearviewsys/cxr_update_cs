//%attributes = {}
// myAlert_AccessDenied ({message})
// displays an alert

C_TEXT:C284($1; $message)

Case of 
		
	: (Count parameters:C259=0)
		$message:="Access Denied"
	: (Count parameters:C259=1)
		$message:=$1+" not allowed!"
	Else 
		
End case 
myAlert($message)