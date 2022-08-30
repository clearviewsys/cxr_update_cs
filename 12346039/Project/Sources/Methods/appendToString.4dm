//%attributes = {}
// appendToString ( ->source;what; {lineFeed?} )
// adds a string to end of first string if the second string 

C_POINTER:C301($1; $sourcePtr)

C_TEXT:C284($2; $stringToAdd)
C_BOOLEAN:C305($3; $doLineFeed)

$sourcePtr:=$1
$stringToAdd:=$2
$doLineFeed:=True:C214

Case of 
	: (Count parameters:C259=4)
		$doLineFeed:=$4
End case 

$sourcePtr->:=$sourcePtr->+$stringToAdd

If ($doLineFeed)
	$sourcePtr->:=$sourcePtr->+CRLF
End if 
