//%attributes = {}
// appendLabelString (->var;label;stringToAppend;{doNewLine?})
// adds a string to end of first string if the second string is not empty

C_POINTER:C301($1)
C_TEXT:C284($2; $3)
C_BOOLEAN:C305($4)

If ($3#"")
	$1->:=$1->+$2+" "+$3
	
	If (Count parameters:C259=4)
		If ($4)
			$1->:=$1->+CRLF
		End if 
	End if 
	
End if 

