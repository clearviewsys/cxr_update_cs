//%attributes = {}
// getUpsellAmount (amount; currency) -> real

C_REAL:C285($amount; $1)
C_TEXT:C284($curr; $2)
C_REAL:C285($result; $smallestDenom; $0)

Case of 
	: (Count parameters:C259=1)
		$amount:=$1
		$curr:=<>BASECURRENCY
		
	: (Count parameters:C259=2)
		$amount:=$1
		$curr:=$2
		
	Else 
		$amount:=278.75
		$curr:="AUD"
End case 

$smallestDenom:=getSmallestDenomForCurrency($curr)

$result:=Int:C8($amount/$smallestDenom)*$smallestDenom
$0:=$result


