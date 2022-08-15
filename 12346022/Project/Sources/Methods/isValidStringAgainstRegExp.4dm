//%attributes = {}
// isValidStringAgainstRegExp (inputString;$pattern;$message;$showMessage)
// Check an string against a Regular expresion and returns true if is valid

C_TEXT:C284($1; $inputString; $2; $pattern; $3; $message)
C_BOOLEAN:C305($0; $4; $showMessage)

$showMessage:=True:C214
$message:="String entered is invalid. Check for special characters or minimal length (3 Chars)."

Case of 
	: (Count parameters:C259=1)
		
		$inputString:=$1
		$pattern:="[a-zA-Z0-9ÀÁÂÄÃÅÈÉÊËÌÍÎÏÒÓÔÖÕØÙÚÛÜŸÑßÇ\\ ,.'-]{3,}\\s*"
		
	: (Count parameters:C259=2)
		
		$inputString:=$1
		$pattern:=$2
		
		
	: (Count parameters:C259=4)
		$inputString:=$1
		$pattern:=$2
		$message:=$3
		$showMessage:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$0:=True:C214
If ($inputString#"")
	If (Match regex:C1019($pattern; $inputString))
		// Do nothing
	Else 
		$0:=False:C215
		If ($showMessage)
			myAlert($message; "Invalid Entry")
		End if 
	End if 
End if 

