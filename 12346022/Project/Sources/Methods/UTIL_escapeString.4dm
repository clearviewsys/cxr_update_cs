//%attributes = {}
// ----------------------------------------------------
// Method: UTIL_EscapeString
// Description
// This method will place \\ (escape) in front of all provide characters
// in the given string in $1
//
// Parameters
// $1 - Given String
// ${2} - Characters or string to be escaped
//
// Return
// $0 - Result String
// ----------------------------------------------------

C_TEXT:C284($0; $1; ${2}; $String_T)
C_LONGINT:C283($param_L; $i)

$param_L:=Count parameters:C259
If ($param_L>1)
	$String_T:=$1
	
	For ($i; 2; $param_L)
		If (Position:C15(${$i}; $String_T)>0)
			$String_T:=Replace string:C233($String_T; ${$i}; "\\"+${$i})
		End if 
	End for 
End if 

$0:=$String_T