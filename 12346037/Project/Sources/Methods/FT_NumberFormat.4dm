//%attributes = {}

// ------------------------------------------------------------------------------
// Method: FT_NumberFormat : 
// Format a number returning a String filled with a pad 
// 
// Parameters: 
//   $1: Number to format  (Input - Number) 
//   $2: Number of decimals required - 0: Number as is-  (Input - Number)
//   $3: Pad length   (Input - Number) 
//   $4: Pad String (default = "0")   (Input - String)  (optional)
//   $5: Number Alignment: LJ | RJ (default) | CE (Input - text)  (optional)
//
// Return:
//   $0: Number formated  (Output - String)
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/07/2015
// ------------------------------------------------------------------------------
C_REAL:C285($1; $numberToFormat)
C_LONGINT:C283($2; $decimalPlaces; $i; $j)  // Decimal Places
C_LONGINT:C283($3; $padLength)  // Pad Length
C_TEXT:C284($4; $padString)  // Pad String
C_TEXT:C284($5; $alignment)  // Alignment

C_TEXT:C284($0)
C_TEXT:C284($fmt)


Case of 
		
	: (Count parameters:C259=1)
		
		$numberToFormat:=$1
		$decimalPlaces:=2
		$padLength:=10
		$padString:="0"
		$alignment:="RJ"
		
	: (Count parameters:C259=2)
		
		$numberToFormat:=$1
		$decimalPlaces:=$2
		$padLength:=10
		$padString:="0"
		$alignment:="RJ"
		
		
	: (Count parameters:C259=3)
		
		$numberToFormat:=$1
		$decimalPlaces:=$2
		$padLength:=$3
		$padString:="0"
		$alignment:="RJ"
		
	: (Count parameters:C259=4)
		
		$numberToFormat:=$1
		$decimalPlaces:=$2
		$padLength:=$3
		$padString:=$4
		$alignment:="RJ"
		
	: (Count parameters:C259=5)
		
		$numberToFormat:=$1
		$decimalPlaces:=$2
		$padLength:=$3
		$padString:=$4
		$alignment:=$5
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($padString=" ")
	$padString:="0"
End if 


$fmt:=""
$j:=0
If ($decimalPlaces>0)
	$j:=1
End if 

For ($i; 1; $padLength-$decimalPlaces-$j)
	$fmt:=$fmt+$padString
End for 

If ($decimalPlaces>0)
	$fmt:=$fmt+"."
End if 

For ($i; 1; $decimalPlaces)
	$fmt:=$fmt+"0"
End for 

$0:=String:C10($numberToFormat; $fmt)

// TODO: LJ: Left Justified
