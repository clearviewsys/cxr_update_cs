//%attributes = {}
// this method either return null string or return the appended string
// ex: use for adding commas before a postal code only if there is a postal code

C_TEXT:C284($1; $2; $0)
If ($2#"")
	$0:=$1+$2
Else 
	$0:=""
End if 
