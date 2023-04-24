//%attributes = {}
#DECLARE($pattern : Text; $string : Text)->$result : Collection

var $start; $i : Integer
var $ok : Boolean

$start:=1
ARRAY LONGINT:C221($pos_found; 0)
ARRAY LONGINT:C221($length_found; 0)

$ok:=Match regex:C1019($pattern; $string; $start; $pos_found; $length_found)

If ($ok)
	$result:=New collection:C1472
	For ($i; 1; Size of array:C274($pos_found))
		$result.push(Substring:C12($string; $pos_found{$i}; $length_found{$i}))
	End for 
End if 
