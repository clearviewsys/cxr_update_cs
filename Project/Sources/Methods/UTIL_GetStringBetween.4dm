//%attributes = {}

// ----------------------------------------------------
// User name (OS): truegold
// Date and time: 04/05/19, 09:25:07
// ----------------------------------------------------
// Method: UT_GetStringBetween
// Description
//Bob Miller 11/23/2015 Util_GetStringBetween - takes string $1, returns substring between $2 and $3 (finds $2 first)
//Example:  MyGetStringBetween("The quick brown fox";"q";"k") --> finds position of first "k", then seeks the first "q" before it, returns "uic"
// 
//If $3 not found, then returns ""
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($u190409)
C_TEXT:C284($1; $2; $3; $0; $StartString; $FirstChar; $LastChar)
C_LONGINT:C283($WhereFirst; $WhereLast)
$0:=""

$StartString:=$1
$FirstChar:=$2
$LastChar:=$3

$WhereFirst:=Position:C15($FirstChar; $StartString)

If ($WhereFirst>0)
	
	$WhereLast:=Position:C15($LastChar; $StartString; $WhereFirst+1)
	
	If ($WhereLast>0)
		
		$0:=Substring:C12($StartString; $WhereFirst+1; $WhereLast-$WhereFirst-1)
		
	End if   //$WhereLast>0)
End if   //$WhereFirst>0
