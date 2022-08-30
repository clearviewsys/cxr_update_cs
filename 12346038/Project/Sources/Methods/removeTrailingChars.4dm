//%attributes = {}
// removeTrailingChars (string; stringToRemove) : string
// e.g. removeTrailingChars ("tiran+++-*";"+-") -> "tiran*"
// see also: removeMiddleExtraSpace
// removes all trailing spaces in a string and returns the string
//
C_TEXT:C284($1; $0; $2; $string; $spaceChar)
$spaceChar:=" "

Case of 
	: (Count parameters:C259=0)
		$string:="tiran*--  "
		$spaceChar:="* -_/"
		
	: (Count parameters:C259=1)
		$string:=$1
		
	: (Count parameters:C259=2)
		$string:=$1
		$spaceChar:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If (Length:C16($string)>0)
	C_LONGINT:C283($position)
	C_BOOLEAN:C305($isFound)
	C_TEXT:C284($lastChar; $result)
	$lastChar:=Substring:C12($string; Length:C16($string); 1)  // the last character of the string
	$isfound:=(Position:C15($lastChar; $spaceChar)>0)  // the first char is one of the spaceChars
	
	If ($isFound)  // if the string starts with a space
		$result:=removeTrailingChars(Substring:C12($string; 1; Length:C16($string)-1); $spaceChar)  // recursively call the same method with a shorter string
	Else   // if the string does not start with a space then return itself 
		$result:=$string
	End if 
	$0:=$result
End if 
//
//C_TEXT($1;$0)
//C_LONGINT($len)
//$len:=Length($1)
//
//$0:=$1
//
//If ($len>0)
//
//If (Substring($1;$len;1)=" ")  // if the string ends with a space
//$0:=removeTrailingSpaces (Substring($1;1;$len-1))  // recursively call the same method with a shorter string
//
//Else   // if the string does not start with a space then return itself 
//$0:=$1
//End if 
//
//End if 