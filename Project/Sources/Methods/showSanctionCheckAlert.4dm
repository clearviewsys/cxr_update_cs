//%attributes = {}
// showSanctionCheckAlert($match)

C_LONGINT:C283($1; $match)
C_TEXT:C284($2; $SanctionCheckTextResult; $subject)


$subject:=""

Case of 
	: (Count parameters:C259=2)
		$match:=$1
		$SanctionCheckTextResult:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: ($match=2)
		myAlert($SanctionCheckTextResult; "AML WARNING: This name matches with a name on a sanction list.")
		
	: ($match=1)
		myAlert($SanctionCheckTextResult; "AML WARNING: This name has possible matches with a name on a sanction list.")
		
	: ($match=-1)
		myAlert($SanctionCheckTextResult; "System Error")
		
End case 