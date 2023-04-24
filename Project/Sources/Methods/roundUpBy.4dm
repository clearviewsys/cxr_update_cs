//%attributes = {}
// roundUpBy (number; denom) 
// this method rounds a number up by a denomination

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
	If (roundDownBy($number; $denom)=$number)
		$result:=$number
	Else 
		$result:=roundDownBy($number; $denom)+$denom
	End if 
End if 

$0:=$result

