//%attributes = {}
// replaceXYZTags (->string; <X> {; <Y> {; <Z>} )
// This method replaces <X>, <Y>, and <Z> tags in the string with respective strings 
//
// Parameters:
//   $1: Pointer to main string that includes the <X>, <Y> or <Z> tag
//   $2..$3: Optional Replacements strings to replace the <X>, <Y> or <Z> tags


C_POINTER:C301($1)
C_TEXT:C284($2; $str1; $3; $str2; $4; $str3)

// Define local variables
C_TEXT:C284($string)

// Verify the number of parameters sent to the method

Case of 
	: (Count parameters:C259=1)
		$string:=$1->
		
	: (Count parameters:C259=2)
		
		$string:=$1->
		$str1:=$2
		
	: (Count parameters:C259=3)
		
		$string:=$1->
		$str1:=$2
		$str2:=$3
		
	: (Count parameters:C259=4)
		
		$string:=$1->
		$str1:=$2
		$str2:=$3
		$str3:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Replace the tags <X>, <Y> or <Z> with the values sent to the method

If ($str1#"")
	$string:=Replace string:C233($string; "<X>"; $str1)
End if 

If ($str2#"")
	$string:=Replace string:C233($string; "<Y>"; $str2)
End if 

If ($str3#"")
	$string:=Replace string:C233($string; "<Z>"; $str3)
End if 

$1->:=$string