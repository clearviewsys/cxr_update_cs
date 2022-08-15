//%attributes = {}
// getFeeStructure ( 
// $1 :  feeStructureID ;
// $2 : ->foreignFee
// $3 : ->commission
// $4 : ->localFee;
// $5 : ->customerID
// $6 : ->fromAmount
// $7 : ->fromCurrency
// $8 : ->toAmount
// $9 : ->toCurrency
// $10 :

// returns the fee structure in the vars or fields that have been passed to the method

C_TEXT:C284($1)
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8; $9; $10)

READ ONLY:C145([FeeStructures:38])
QUERY:C277([FeeStructures:38]; [FeeStructures:38]FeeStructureID:1=$1)

If (Records in selection:C76([FeeStructures:38])>0)  // if found 
	FIRST RECORD:C50([FeeStructures:38])
	//$2->:=[FeeStructures]_
	$3->:=[FeeStructures:38]PercentCommission:3
	$4->:=[FeeStructures:38]FlatLocalFee:4
	//setIfNotNullString ($5;[FeeStructures]CustomerID)
	//setIfNotZero ($6;[FeeStructures]fromAmount)
	//setIfNotNullString ($7;[FeeStructures]fromCurrency)
	//setIfNotZero ($8;[FeeStructures]toAmount)
	//setIfNotNullString ($9;[FeeStructures]toCurrency)
End if 
