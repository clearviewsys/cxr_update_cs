//%attributes = {}
// removeLeadingChars (string; {spaceChar}) : string
// see also: removeTrailingSpaces 
// e.g. removeLeadingChars ("**--tiran";"*-") -> "tiran"
// removes all leading spaces in a string and returns the string

C_TEXT:C284($1; $0; $2; $string; $spaceChar)

Case of 
	: (Count parameters:C259=0)
		$string:="***---  tiran "
		$spaceChar:="* -_/"
		
	: (Count parameters:C259=1)
		$string:=$1
		$spaceChar:=" "
		
	: (Count parameters:C259=2)
		$string:=$1
		$spaceChar:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$0:=$string

If (Length:C16($string)>0)
	C_LONGINT:C283($position)
	C_BOOLEAN:C305($isFound)
	C_TEXT:C284($firstChar; $result)
	$firstChar:=Substring:C12($string; 1; 1)
	$isfound:=(Position:C15($firstChar; $spaceChar)>0)  // the first char is one of the spaceChars
	
	If ($isFound)  // if the string starts with a space
		$result:=removeLeadingChars(Substring:C12($string; 2); $spaceChar)  // recursively call the same method with a shorter string
	Else   // if the string does not start with a space then return itself 
		$result:=$string
	End if 
	
	$0:=$result
End if 