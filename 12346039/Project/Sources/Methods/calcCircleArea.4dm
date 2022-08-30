//%attributes = {}
// calcCircleArea ( real: r) -> real
// this function calculates the area of a circle using its radius

C_REAL:C285($0; $1; $r; $area)

Case of 
	: (Count parameters:C259=0)
		$r:=10  // test default case
		
	: (Count parameters:C259=1)
		$r:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$area:=Pi:K30:1*($r^2)

$0:=$area



