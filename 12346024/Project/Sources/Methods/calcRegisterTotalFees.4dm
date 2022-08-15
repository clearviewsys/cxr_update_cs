//%attributes = {}
// calcRegisterTotalFees (debit; credit; ourRate; percentFee; feeLocal)


C_REAL:C285($0)
C_REAL:C285($debit; $credit; $ourRate; $percentFee; $feeLocal; $1; $2; $3; $4; $5)

Case of 
	: (Count parameters:C259=5)
		$debit:=$1
		$credit:=$2
		$ourRate:=$3
		$percentFee:=$4
		$feeLocal:=$5
	Else 
		$debit:=[Registers:10]Debit:8
		$credit:=[Registers:10]Credit:7
		$ourRate:=[Registers:10]OurRate:25
		$percentFee:=[Registers:10]percentFee:28
		$feeLocal:=[Registers:10]feeLocal:29
End case 

//$0:=Round(Abs($Credit-$Debit)*$OurRate*($percentFee/100)+$feeLocal;◊roundDigitBaseCurrency)

$0:=Round:C94(Abs:C99($credit-$debit)*$ourRate*($percentFee/100)+$feeLocal; <>roundDigitBaseCurrency)
