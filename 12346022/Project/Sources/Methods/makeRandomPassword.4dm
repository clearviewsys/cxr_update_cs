//%attributes = {}
// makeTemporaryPassword -> string


C_TEXT:C284($0; $pass)
C_LONGINT:C283($i)
For ($i; 1; 6)
	$pass:=$pass+Char:C90(Character code:C91("A")+(Random:C100%26))
	
End for 
$0:=$pass+String:C10(convDate2Serial(Current date:C33))+String:C10(Random:C100; "00000")
