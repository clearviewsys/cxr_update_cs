//%attributes = {}
// Helper: String Tokenizer

// @author Jonathan Le


// The aim of this method is to parse a string buffer for "tokens" delimited by a delimiter "delimiter"

// This method takes in 3 parameters:

// @param $1 - the array to put the tokens into

// @param $2 - a string buffer to parse

// @param $3 - a delimiter

// @return  - the number of tokens in the list


// example: String_Tokenizer($sbuffer;",")

// the above would tokenize words from $sbuffer separated by commas


C_TEXT:C284($2; $3; $stringBuffer; $delim)
C_TEXT:C284($token; $char)
C_LONGINT:C283($0; $curPos; $length; $elemIndex)
C_POINTER:C301($1; $tokenList)

DEBUG:=False:C215

// initialize our local variables

$tokenList:=$1
$stringBuffer:=$2
$delim:=$3
$length:=Length:C16($stringBuffer)
$elemIndex:=0

If (Size of array:C274($tokenList->)>0)
	DELETE FROM ARRAY:C228($tokenList->; 1; Size of array:C274($tokenList->))
End if 

While (($length>0))  // for debug
	
	// initialize our scope variables
	
	$token:=""
	$curPos:=1
	$elemIndex:=$elemIndex+1
	
	// expand the array as necessary
	
	INSERT IN ARRAY:C227($tokenList->; $elemIndex)
	
	// parse the text input one character at a time until either delim
	
	// is reached and we have successfuly created a token or length has been reached
	
	Repeat 
		$char:=Substring:C12($stringBuffer; $curPos; 1)
		
		If ($char#$delim)
			$token:=$token+$char
		End if 
		
		$curPos:=$curPos+1
	Until ((($char=$delim) & ($token#"")) | ($curPos>$length))
	
	// reset the string buffer
	
	$stringBuffer:=Substring:C12($stringBuffer; $curPos)
	$length:=Length:C16($stringBuffer)
	
	// add the token to the list if not null
	
	If ($token#"")
		$tokenList->{$elemIndex}:=$token
		
		If (DEBUG)
			myAlert($tokenList->{$elemIndex})
		End if 
	End if 
	
End while 

// return true on condition: added elements

$0:=Size of array:C274($tokenList->)