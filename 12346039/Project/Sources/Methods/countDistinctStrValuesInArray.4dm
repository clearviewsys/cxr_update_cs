//%attributes = {}
// countDistinctStrValInArray(->array) : longint
// return the number of distinct values in the array
// PRE:array must be sorted

C_LONGINT:C283($i; $n; $count; $0)
C_TEXT:C284($str1; $str2)

C_POINTER:C301($arrayPtr; $1)

$arrayPtr:=$1
$n:=Size of array:C274($arrayPtr->)

If ($n>0)
	$str1:=$arrayPtr->{1}
	$count:=1
	
	For ($i; 2; $n)
		$str2:=$arrayPtr->{$i}
		If ($str1#$str2)
			$count:=$count+1
			$str1:=$str2
		End if 
	End for 
	
End if 

$0:=$count