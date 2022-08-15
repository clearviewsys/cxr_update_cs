//%attributes = {}
// breakAmountIntoDenoms(amount;->denomArray;->resultArr;->availabilityArray) : reminder
// breaks an amount into denominations using an array or denominations


C_REAL:C285($1; $number; $remainder)
C_POINTER:C301($2; $3; $4; $denomArrPtr; $availabilityArrPtr; $resultArrPtr)
C_BOOLEAN:C305($considerAvailability)
C_LONGINT:C283($n; $i)

$number:=$1
$denomArrPtr:=$2
$resultArrPtr:=$3
If (Count parameters:C259=4)
	$availabilityArrPtr:=$4
	$considerAvailability:=True:C214
Else 
	$considerAvailability:=False:C215
End if 

$n:=Size of array:C274($denomArrPtr->)

C_REAL:C285($result; $remainder)
For ($i; 1; $n)
	If ($considerAvailability)
		$result:=calcMin(Int:C8($number/$denomArrPtr->{$i}); $availabilityArrPtr->{$i})
	Else 
		$result:=Int:C8($number/$denomArrPtr->{$i})
	End if 
	$remainder:=$number-($result*$denomArrPtr->{$i})
	$resultArrPtr->{$i}:=$result
	$number:=$remainder
End for 

$0:=$remainder