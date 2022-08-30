//%attributes = {}
// isTextChanged(string; reset) : bool
// this method returns true if the value of string has changed since last time this method was called
// this is useful for manual break processing using Print Form method, so whenever the value of a key variable changes we can print a break

C_TEXT:C284($1; textChanged)
C_BOOLEAN:C305($2; $reset; $0)

$reset:=$2
If ($reset)
	textChanged:=$1
End if 

If (textChanged#$1)
	$0:=True:C214
	textChanged:=$1
Else 
	$0:=False:C215
End if 

