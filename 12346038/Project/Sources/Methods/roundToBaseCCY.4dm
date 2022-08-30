//%attributes = {}
// roundToBase (value; {roundDenom};{direction:int})->value 
// this method rounds a value to the denomination of the base currency
// see also: roundThisToBase
// round direction: (0: neutral); (1: down) ; (2:up) 


C_REAL:C285($1; $0; $2)
C_LONGINT:C283($3; $direction)

C_REAL:C285($up; $down; $number; $result; $diffUp; $diffDown; $round)
C_REAL:C285(<>minDenominationBaseCCY)

$round:=<>minDenominationBaseCCY

$direction:=0  // neutral rounding (not in favor of customer nor the company)

Case of 
	: (Count parameters:C259=0)
		$round:=0.05  // like in Switzerland
		$number:=102.36
		
	: (Count parameters:C259=1)
		$number:=$1
		
	: (Count parameters:C259=2)
		$number:=$1
		$round:=$2
		
	: (Count parameters:C259=3)
		$number:=$1
		$round:=$2
		$direction:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$up:=roundUpBy($number; $round)
$down:=roundDownBy($number; $round)

$diffUp:=$up-$number
$diffDown:=$number-$down

Case of 
	: ($direction=0)  // neutral rounding. rounds towards the closest number
		
		If ($diffUp>=$diffDown)  // result is the rounded number that is closer to the original number
			$result:=$down
		Else 
			$result:=$up
		End if 
		
	: ($direction=1)  // down
		$result:=$down
		
	: ($direction=2)  // up
		$result:=$up
	Else 
		ASSERT:C1129(True:C214; "Invalid parameter: direction sent to 'roundToBase' method. "+String:C10($direction))
End case 


$0:=$result

