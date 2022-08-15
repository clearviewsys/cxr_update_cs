//%attributes = {}
// FT_GetStringTime($time) -> Hour in format HHMMSS
// Converts a time in a String format HHMMSS

C_TIME:C306($1; $refTime)
C_TEXT:C284($0; $timeSeparator; $format)

Case of 
	: (Count parameters:C259=0)
		$refTime:=Current time:C178(*)
		$timeSeparator:=""
		
	: (Count parameters:C259=1)
		$refTime:=$1
		$timeSeparator:=""
		
		
	: (Count parameters:C259=2)
		$refTime:=$1
		$timeSeparator:=$2
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$0:=Replace string:C233(String:C10($refTime; "HH:MM:SS"); ":"; $timeSeparator)  // Converts time to String and replace the : chars by null 




