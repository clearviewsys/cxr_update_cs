//%attributes = {}

// ----------------------------------------------------
// User name (OS): madamov
// Date and time: 02/05/97, 11:45:28
// ----------------------------------------------------
// Method: STR_TrimFromLeft
// Description
// 
// Trims characters in $2 from left and right side of $1
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $StrToTrim_t)
C_TEXT:C284($2; $CharactersToTrim_s)
C_TEXT:C284($0)

$StrToTrim_t:=$1
If (Count parameters:C259>1)
	$CharactersToTrim_s:=$2
Else 
	$CharactersToTrim_s:=" "  // assume trimming of spaces only
End if 

$0:=strTrimFromRight(strTrimFromLeft($StrToTrim_t))
