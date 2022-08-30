//%attributes = {}
// fillDenominationArray(->array;value;currency)

C_POINTER:C301($1; $arrPtr)
C_REAL:C285($2; $amount)
C_TEXT:C284($3; $currency)
$arrPtr:=$1
$amount:=$2
$Currency:=$3

READ ONLY:C145([Denominations:31])
QUERY:C277([Denominations:31]; [Denominations:31]Currency:2=$Currency)
QUERY SELECTION:C341([Denominations:31]; [Denominations:31]Value:3<=$amount)
If ($amount=Int:C8($amount))  // it's an integer therefore filter the coins denomination
	
	QUERY SELECTION:C341([Denominations:31]; [Denominations:31]Value:3>=1)
End if 
orderByDenominations
//ORDER BY([Denominations];[Denominations]Currency;>;[Denominations]Value;>)

SELECTION TO ARRAY:C260([Denominations:31]Value:3; $arrPtr->)
