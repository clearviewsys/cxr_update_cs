//%attributes = {}
// replaceRegExp ($inputStringPtr; $regExp)
// Get rid all the chars matches with $regFrom from $inputString

C_POINTER:C301($1; $inputStringPtr)
C_TEXT:C284($2; $regExp; $tmp)

C_BOOLEAN:C305($found)
C_LONGINT:C283($pos; $length)

Case of 
	: (Count parameters:C259=1)
		
		$inputStringPtr:=$1
		$regExp:="[0-9]+"  // Replace numbers from string (default replacement)
		
	: (Count parameters:C259=2)
		
		$inputStringPtr:=$1
		$regExp:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Repeat 
	$found:=Match regex:C1019($regExp; $inputStringPtr->; 1; $pos; $length)
	If ($found)
		$tmp:=Substring:C12($inputStringPtr->; $pos; $length)
		$inputStringPtr->:=Replace string:C233($inputStringPtr->; $tmp; "")
	End if 
Until (Not:C34($found))
