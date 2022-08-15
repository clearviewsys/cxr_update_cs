//%attributes = {}
// scaleArray ( ->Array; scale: real)
// this method scales the elemets of a real array by 'scale' factor

C_POINTER:C301($arrayPtr; $1)
C_REAL:C285($scale; $2)
C_LONGINT:C283($i; $n)

$arrayPtr:=$1
$scale:=$2

If (Not:C34(Is nil pointer:C315($arrayPtr)))
	$n:=Size of array:C274($arrayPtr->)
	
	For ($i; 1; $n)
		$arrayPtr->{$i}:=$arrayPtr->{$i}*$scale  // scale each element by 'scale' factor
	End for 
End if 

