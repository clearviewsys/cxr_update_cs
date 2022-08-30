//%attributes = {}
// AmountToSpotRate
// Convert the amount to the market rate


C_REAL:C285($1; $amount; $amountNotRate)
C_REAL:C285($0)


Case of 
	: (Count parameters:C259=1)
		$amount:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ([Registers:10]OurRate:25>0)
	$amountNotRate:=$amount/[Registers:10]OurRate:25
	$amount:=$amountNotRate*[Registers:10]SpotRate:26
Else 
	$amount:=0
End if 

$0:=$amount






