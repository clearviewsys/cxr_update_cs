//%attributes = {}
// removeChars (string; charsToRemove)

C_TEXT:C284($string; $chars; $1; $2)
C_TEXT:C284($result; $0)


Case of 
	: (Count parameters:C259=0)
		$string:="tiran*--  "
		$chars:="* -_/"
		
	: (Count parameters:C259=1)
		$string:=$1
		
	: (Count parameters:C259=2)
		$string:=$1
		$chars:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_TEXT:C284($char)
C_LONGINT:C283($len)
$len:=Length:C16($string)

If ($len>0)
	$char:=Substring:C12($string; 1; 1)  // first char
	If (Position:C15($char; $chars)>0)  // if found the char in the chars we eliminate it
		$result:=removeChars(Substring:C12($string; 2); $chars)
	Else 
		$result:=$char+removeChars(Substring:C12($string; 2); $chars)
	End if 
Else 
	$result:=""
End if 

$0:=$result