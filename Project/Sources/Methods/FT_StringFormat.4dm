//%attributes = {}

// ------------------------------------------------------------------------------
// Method: FT_StringFormat: 
// Format a string returning String filled with a pad 
// 
// Parameters: 
//   $1: String to format  (Input - String) 
//   $2: Pad length   (Input - Number) 
//   $3: Pad String (default = " ")   (Input - String)  (optional)
//   $4: Alignment: LJ | RJ | CE  (LJ: left default)| RJ: Right Just | CE: Center (Input - text)  (optional)
//
// Return:
//   $0: Number formated  (Output - String)
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/07/2015
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $stringToFormat)
C_LONGINT:C283($2; $padLength; $i)  // Pad Length
C_TEXT:C284($3; $padString)  // Pad String
C_TEXT:C284($4; $alignment)  // Alignment

C_TEXT:C284($0; $tmp; $fmt)
$tmp:="                                                                                                    "  // 100 spaces
$tmp:=$tmp+$tmp+$tmp+$tmp+$tmp  // 500 spaces

Case of 
		
	: (Count parameters:C259=2)
		
		$stringToFormat:=$1
		$padLength:=$2
		$padString:=" "
		$alignment:="LJ"
		
	: (Count parameters:C259=3)
		$stringToFormat:=$1
		$padLength:=$2
		$padString:=$3
		$alignment:="LJ"
		
	: (Count parameters:C259=4)
		$stringToFormat:=$1
		$padLength:=$2
		$padString:=$3
		$alignment:=Uppercase:C13($4)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Length:C16($stringToFormat)>$padLength)
	$stringToFormat:=Substring:C12($stringToFormat; 1; $padLength)
End if 

C_TEXT:C284($fmt)
$fmt:=Substring:C12($tmp; 1; $padLength)

Case of 
	: ($alignment="LJ")
		
		$fmt:=$stringToFormat+$tmp
		$fmt:=Substring:C12($fmt; 1; $padLength)
		
	: ($alignment="RJ")
		$fmt:=$tmp+$stringToFormat
		$i:=Length:C16($fmt)-$padLength+1
		$fmt:=Substring:C12($fmt; $i)
		
End case 

If ($padString#" ")
	$fmt:=Replace string:C233($fmt; " "; $padString)
End if 

$0:=$fmt

