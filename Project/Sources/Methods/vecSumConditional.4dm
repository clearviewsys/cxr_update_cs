//%attributes = {}
// vecSumConditional (-> vector; ->conditionvection; ->value;checkeQuality) -> real
// this method returns the sum of the vector where the element


C_POINTER:C301($1; $2; $3; $arrayPtr; $conditionArrayPtr; $valuePtr)
C_BOOLEAN:C305($4; $checkEquality)

$arrayPtr:=$1
$conditionArrayPtr:=$2
$valuePtr:=$3
$checkEquality:=$4



C_REAL:C285($0; $sum)
C_LONGINT:C283($i; $n)

$sum:=0
$n:=Size of array:C274($arrayPtr->)

If ($checkEquality)
	For ($i; 1; $n)
		If ($conditionArrayPtr->{$i}=$valuePtr->)
			$sum:=$sum+$arrayPtr->{$i}
		End if 
	End for 
Else 
	For ($i; 1; $n)
		If ($conditionArrayPtr->{$i}#$valuePtr->)
			$sum:=$sum+$arrayPtr->{$i}
		End if 
	End for 
	
End if 

$0:=$sum
