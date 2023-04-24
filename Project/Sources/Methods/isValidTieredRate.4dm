//%attributes = {}


C_REAL:C285($1; $rAmount)
C_REAL:C285($2; $rLowerLimit)
C_REAL:C285($3; $rUpperLimit)

C_BOOLEAN:C305($0; $isValid)

$isValid:=False:C215

If (Count parameters:C259=3)
	$rAmount:=$1
	$rLowerLimit:=$2
	$rUpperLimit:=$3
Else 
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 


Case of 
	: ($rAmount>=$rLowerLimit) & ($rAmount<=$rUpperLimit)  //upper and lower limit
		$isValid:=True:C214
	: ($rLowerLimit=0) & ($rUpperLimit=0)  //no limits
		$isValid:=True:C214
	: ($rAmount>=$rLowerLimit) & ($rUpperLimit=0)  //lower limit only
		$isValid:=True:C214
	: ($rLowerLimit=0) & ($rAmount<=$rUpperLimit)  //upper limit only - this should be caught above
		$isValid:=True:C214
	Else 
		$isValid:=False:C215
End case 


$0:=$isValid