//%attributes = {}
//setExchangeRate ( ->ratePtr;->inverseRatePtr; {received/paid};vBuyRate;vSellRate;{isForced})
// use the isForced option when you want the rate to be changed no matter what the use has already entered 
// in the rate field. it's good hen user seelcts another currency from the menu

C_POINTER:C301($1; $2; $ratePtr; $inverseRatePtr)
C_TEXT:C284($3; $receivedOrPaid)
C_REAL:C285($4; $5; $buyRate; $sellRate)
C_BOOLEAN:C305($isForced; $6)

$ratePtr:=$1
$inverseRatePtr:=$2
$receivedOrPaid:=$3
$buyRate:=$4
$sellRate:=$5

If (Count parameters:C259=6)
	$isForced:=$6
Else 
	$isForced:=False:C215
End if 

If (($ratePtr->=0) | ($isForced=True:C214))
	Case of 
		: ($receivedOrPaid=getReceivedOrPayString(1))  // received
			$ratePtr->:=$buyRate
			
		: ($receivedOrPaid=getReceivedOrPayString(2))  // received
			$ratePtr->:=$sellRate
			
		Else   // paid
			
			$ratePtr->:=$sellRate
	End case 
	
End if 


$inverseRatePtr->:=Round:C94(calcSafeDivide(1; $ratePtr->); [Currencies:6]RoundDigitInverse:28)
//$inverseRatePtr->:=calcSafeDivide (1;$ratePtr->)
