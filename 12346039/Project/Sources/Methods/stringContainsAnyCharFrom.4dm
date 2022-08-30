//%attributes = {}

// stringContainsAnyCharFrom (source; lookupCharString)
// this method returns true if any of the characters in lookupCharString is found in the source string
// if $3 is true search is case sensitive, default is case insensitive
// Unit test @Zoya

C_TEXT:C284($str; $lookupStr; $char; $char2; $1; $2)
C_BOOLEAN:C305($3; $caseSensitive)
C_BOOLEAN:C305($0; $isFound)
C_LONGINT:C283($i; $n; $pos)

$isFound:=False:C215
$caseSensitive:=False:C215

Case of 
	: (Count parameters:C259=0)
		$str:="abc"
		$lookupStr:="ABCDEFGH"
		
	: (Count parameters:C259=2)
		$str:=$1
		$lookupStr:=$2
		
	: (Count parameters:C259=3)
		$str:=$1
		$lookupStr:=$2
		$caseSensitive:=$3
		
	Else 
		ASSERT:C1129(False:C215; "Invalid number of params")
End case 

$n:=Length:C16($lookupStr)

For ($i; 1; $n)
	// $char:=Substring($lookupStr; $i; 1)  // char[i] from the lookup string
	$char:=$lookupStr[[$i]]  // this is faster than substring because we are returning one char only
	
	If ($caseSensitive)
		$pos:=Position:C15($char; $str; *)  // if the char is found in the str, then we need verify the ascii chars are the same
	Else 
		$pos:=Position:C15($char; $str)
	End if 
	
	If ($pos>0)
		$isFound:=True:C214
		$i:=$n  // end the loop
	End if 
End for 

$0:=$isFound
