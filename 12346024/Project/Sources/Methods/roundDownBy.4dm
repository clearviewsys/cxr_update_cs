//%attributes = {}
// roundDownBy (real; real)

// this method rounds a number down to a number 
// roundDownToDenom (number; denomination)
// this method rounds the number to the 

// Unit test is written

C_REAL:C285($1; $2; $number)
C_REAL:C285($0; $quotient; $result; $denom)

Case of 
		
	: (Count parameters:C259=0)
		$number:=1000.33
		$denom:=0.25
		
	: (Count parameters:C259=2)
		$number:=$1
		$denom:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($denom=0)
	$result:=$number
Else 
	$quotient:=Int:C8(calcSafeDivide($number; $denom))
	$result:=$quotient*$denom
End if 

$0:=$result

