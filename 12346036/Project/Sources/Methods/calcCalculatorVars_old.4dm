//%attributes = {}

C_REAL:C285(vFromAmount; vToAmount; vExchangeRate; vRate1; vRate2)

C_LONGINT:C283(cbFeePaidSeparately; rbFromAmount; rbExchangeRate; rbServiceFee; rbToAmount)
C_REAL:C285($from; $to; $rate; $fee; $0; $rate1; $rate2; $fee2)
$from:=vFromAmount
$to:=vToAmount
$rate:=vExchangeRate
$rate1:=vRate1
$rate2:=vRate2
$fee2:=vServiceFee

If (cbFeePaidSeparately=1)
	$fee:=0
Else 
	$fee:=vServiceFee
End if 

Case of   // handling case 
		
	: (rbFromAmount=1)
		Case of   // calculate 'fromAmount'
				
			: (popTransactionType=1)  // buy
				
				If ($rate#0)
					$from:=($to+$fee)/$rate
				End if 
			: (popTransactionType=2)  // sell
				
				If ($rate#0)
					$from:=$fee+($to/$rate)
				End if 
			: (popTransactionType=3)  // cross
				
				If ($Rate1#0)
					$from:=(($to*$rate2)+$fee)/$rate1
				End if 
		End case 
		
	: (rbExchangeRate=1)  // calculate 'exchangeRate'
		
		Case of 
			: (popTransactionType=1)  // buy 
				
				If ($from#0)
					$rate:=($to+$fee)/$from
				End if 
			: (popTransactionType=2)  // sell
				
				If ($from-$fee>0)
					$rate:=$to/($from-$fee)
				End if 
			: (popTransactionType=3)  // cross
				
				If (($from*$rate1)#$fee)
					$rate:=($to*$rate1)/(($from*$rate1)-$fee)
					$rate2:=$rate1/$rate
				End if 
		End case 
		
	: (rbServiceFee=1)  // calculate 'serviceFee'
		
		Case of 
			: (popTransactionType=1)  // buy
				
				$fee:=($from*$rate)-$to
			: (popTransactionType=2)  // sell
				
				If ($rate#0)
					$fee:=$from-($to/$rate)
				End if 
			: (popTransactionType=3)  // cross
				
				If ($rate#0)
					$rate2:=$rate1/$rate
					$fee:=($from*$rate1)-($to*$rate2)
				End if 
		End case 
		$fee2:=$fee
	: (rbToAmount=1)  // calculate 'toAmount'
		
		
		Case of 
			: (popTransactionType=1)  // buy
				
				$to:=($from*$rate)-$fee
			: (popTransactionType=2)  // sell
				
				$to:=($from-$fee)*$rate
			: (popTransactionType=3)  // cross ` X -> Y (Cross)
				
				If ($rate#0)
					$rate2:=$rate1/$rate
					If ($rate2#0)
						$to:=(($from*$rate1)-$fee)/$rate2
					End if 
				End if 
		End case 
End case 



vFromAmount:=$from
vToAmount:=$to
vServiceFee:=$fee2
vExchangeRate:=$rate
vRate1:=$rate1
vRate2:=$rate2