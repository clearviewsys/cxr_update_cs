//%attributes = {}
// handleFillDenominationArray 
// this method is used in the entry form of Denominations
ARRAY REAL:C219(arrDenominations; 0)
C_TEXT:C284($vCurrency)
$vCurrency:=[Denominations:31]Currency:2
PUSH RECORD:C176([Denominations:31])
QUERY:C277([Denominations:31]; [Denominations:31]Currency:2=$vCurrency)
orderByDenominations
SELECTION TO ARRAY:C260([Denominations:31]Value:3; arrDenominations)
POP RECORD:C177([Denominations:31])
