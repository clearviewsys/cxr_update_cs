//%attributes = {}
// removeMiddleExtraSpace (string) : string
// removes all leading spaces in a string and returns the string

C_TEXT:C284($1; $0; $string; $result)
C_LONGINT:C283($i)

Case of 
	: (Count parameters:C259=1)
		$string:=$1
		
		
	Else 
		$string:="tiran  Behrouz    tiran"
End case 
$0:=$string

$i:=Position:C15("  "; $string; 2)


If ($i>0)
	$result:=removeMiddleExtraSpace(Substring:C12($string; 1; $i)+removeLeadingChars(Substring:C12($string; $i+2)))
	
	
	
	//If (Substring($1;1;1)=" ")  // if the string starts with a space
	//$0:=removeLeadingSpaces (Substring($1;2))  // recursively call the same method with a shorter string
	//Else   // if the string does not start with a space then return itself 
	//$0:=$1
	//End if 
Else 
	$result:=$string
End if 

$0:=$result
