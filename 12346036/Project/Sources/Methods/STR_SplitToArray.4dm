//%attributes = {}
// Splits a text into an array given a delimiter
// $1 = Text
// $2 = Delimiter
// $3 = Pointer to array

C_TEXT:C284($1; $2; $vt_Text; $vt_Delimiter)
C_POINTER:C301($3; $vp_Array)
C_LONGINT:C283($vl_Position)

$vt_Text:=$1
$vt_Delimiter:=$2
$vp_Array:=$3

If (Size of array:C274($vp_Array->)>0)
	DELETE FROM ARRAY:C228($vp_Array->; 1; Size of array:C274($vp_Array->))
End if 

While ($vt_Text#"")
	
	$vl_Position:=Position:C15($vt_Delimiter; $vt_Text)
	If ($vl_Position>0)
		APPEND TO ARRAY:C911($vp_Array->; Substring:C12($vt_Text; 1; $vl_Position-1))
		$vt_Text:=Substring:C12($vt_Text; $vl_Position+Length:C16($vt_Delimiter))
	Else 
		APPEND TO ARRAY:C911($vp_Array->; $vt_Text)
		$vt_Text:=""
	End if 
	
End while 
