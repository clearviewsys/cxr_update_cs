//%attributes = {}

C_REAL:C285(vFromAmount; vToAmount; vExchangeRate; vRate1; vRate2; vPercentFee; vForeignFee)

C_LONGINT:C283(cbFeePaidSeparately; rbFromAmount; rbExchangeRate; rbServiceFee; rbToAmount)
C_REAL:C285($from; $to; $rate; $fee; $0; $rate1; $rate2; $fee2; $percentFee; $foreignFee)

$from:=vFromAmount
$to:=vToAmount
$rate:=vExchangeRate
$percentFee:=vPercentFee/100
$foreignFee:=vForeignFee

//vRate1:=vFromMarketAvg
//vRate2:=vToOurSell

$rate1:=vRate1
$rate2:=vRate2
$fee2:=vServiceFee


If (cbFeePaidSeparately=1)
	$fee:=0
Else 
	$fee:=vServiceFee
End if 


If (($rate2=1) & ($rate1#1))  // its is a buy
	$rate1:=$rate
Else 
	If (($rate2#1) & ($rate1=1))  // sell
		$rate2:=1/$rate
	Else   // cross
		$rate2:=$rate1/$rate
	End if 
End if 


Case of   // handling case 
	: (rbFromAmount=1)
		//  If ($Rate1#0)
		$from:=((($to*$rate2)+$fee)/(1-$percentFee)/($rate*$rate2))+$foreignFee
		//  End if 
		lockCalculatorRadioButtons(1)
		
	: (rbExchangeRate=1)  // calculate 'exchangeRate'
		$rate1:=calcSafeDivide((($rate2*$to)+$fee); ((1-$percentFee)*($from-$foreignFee)))
		//$rate2:=calcSafeDivide (($rate1*((1-$percentFee)*($from-$foreignFee)))-$fee;$to)
		$rate:=calcSafeDivide($rate1; $rate2)
		lockCalculatorRadioButtons(2)
		
	: (rbServiceFee=1)  // calculate 'serviceFee'
		If ($rate#0)
			//$rate2:=$rate1/$rate
			$fee:=(($from-$foreignFee)*$rate1*(1-$percentFee))-($to*$rate2)
		End if 
		$fee2:=$fee
		lockCalculatorRadioButtons(3)
		
	: (rbToAmount=1)  // calculate 'toAmount'
		If ($rate#0)
			//$rate1:=$rate2*$rate
			If ($rate2#0)
				$to:=((($from-$foreignFee)*$rate1*(1-$percentFee))-$fee)/$rate2
			End if 
		End if 
		lockCalculatorRadioButtons(4)
		
End case 

vFromAmount:=Round:C94($from; 2)
vToAmount:=Round:C94($to; 2)
vServiceFee:=Round:C94($fee2; 2)
vExchangeRate:=Round:C94($rate; 8)
vInverseRate:=Round:C94(1/$rate; 8)
vRate1:=Round:C94($rate1; 8)
vRate2:=Round:C94($rate2; 8)