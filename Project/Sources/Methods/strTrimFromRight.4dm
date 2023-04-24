//%attributes = {}

// ----------------------------------------------------
// User name (OS): madamov
// Date and time: 02/05/97, 11:34:12
// ----------------------------------------------------
// Method: STR_TrimFromLeft
// Description
// 
// Trims characters in $2 from rigth side of $1
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $StrToTrim_t)
C_TEXT:C284($2; $CharactersToTrim_s)
C_TEXT:C284($0)

C_LONGINT:C283($i; $StrLen_l; $pos)
C_BOOLEAN:C305($KeepGoing_b)

$StrToTrim_t:=$1
If (Count parameters:C259>1)
	$CharactersToTrim_s:=$2
Else 
	$CharactersToTrim_s:=" "  // assume trimming of spaces only
End if 

$StrLen_l:=Length:C16($StrToTrim_t)
$i:=$StrLen_l
$KeepGoing_b:=($i>=1)

While ($KeepGoing_b)
	
	$pos:=Position:C15($StrToTrim_t[[$i]]; $CharactersToTrim_s)
	
	If ($pos>0)
		$i:=$i-1
		$KeepGoing_b:=($i>=1)
	Else 
		$KeepGoing_b:=False:C215
	End if 
End while 

$0:=Substring:C12($StrToTrim_t; 1; $i)
