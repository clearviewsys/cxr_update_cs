//%attributes = {}
// tokenizePhraseIntoWords (string; ->arrOfStrings; delimiter)
// send a string and this will break it into words and fill the string array with the tokens
// this is a recursive method hence it is short and sweet

C_TEXT:C284($1; $string)
C_POINTER:C301($2; $strArrayPtr)
C_TEXT:C284($3; $delim)
ARRAY TEXT:C222($testArr; 0)

Case of 
	: (Count parameters:C259=0)
		$string:="Tiran Behrouz"
		$strArrayPtr:=->$testArr
		$delim:=" "
	: (Count parameters:C259=2)
		$string:=$1
		$strArrayPtr:=$2
		$delim:=" "
		
	: (Count parameters:C259=3)
		$string:=$1
		$strArrayPtr:=$2
		$delim:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($token)
C_LONGINT:C283($found)
$found:=Position:C15($delim; $string; 1)  // find the position of the delimiter in the string

If ($found>0)  // if the delimited is found, tokenize the word starting from the first character
	
	$token:=Substring:C12($string; 1; $found-1)
	APPEND TO ARRAY:C911($strArrayPtr->; $token)
	tokenizePhraseIntoWords(Substring:C12($string; $found+1); $strArrayPtr; $delim)
	
Else   // if the delimiter is not found, add the entire word (string)  to the array
	APPEND TO ARRAY:C911($strArrayPtr->; $string)
End if 
