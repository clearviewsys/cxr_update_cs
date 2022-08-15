//%attributes = {}
// appendToString (condition; ->source;what; {lineFeed?} )
// adds a string to end of first string if the second string 

C_BOOLEAN:C305($1; $condition)
C_POINTER:C301($2; $sourcePtr)

C_TEXT:C284($3; $stringToAdd)
C_BOOLEAN:C305($4; $doLineFeed)

$condition:=$1
$sourcePtr:=$2
$stringToAdd:=$3
$doLineFeed:=True:C214

Case of 
	: (Count parameters:C259=4)
		$doLineFeed:=$4
End case 

If ($condition)
	$sourcePtr->:=$sourcePtr->+$stringToAdd
	If ($doLineFeed)
		$sourcePtr->:=$sourcePtr->+CRLF
	End if 
	
End if 
