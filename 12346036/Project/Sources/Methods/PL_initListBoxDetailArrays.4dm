//%attributes = {}
C_LONGINT:C283($1; $n)

Case of 
	: (Count parameters:C259=0)
		$n:=0
	: (Count parameters:C259=1)
		$n:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222(ARRREGISTERIDS; $n)



ARRAY DATE:C224(ARRDATES; $n)
ARRAY REAL:C219(arrDebits; $n)
ARRAY REAL:C219(arrCredits; $n)
ARRAY REAL:C219(arrRates; $n)
ARRAY REAL:C219(arrInventory; $n)


ARRAY REAL:C219(arrProfits; $n)
ARRAY REAL:C219(arrAvgBuyRates; $n)
ARRAY REAL:C219(arrShortRates; $n)
ARRAY REAL:C219(ARRDEBITLOCALS; $n)
ARRAY REAL:C219(ARRCREDITLOCALS; $n)
ARRAY REAL:C219(ARRFEES; $n)
ARRAY REAL:C219(arrCOGS; $n)
ARRAY REAL:C219(arrNets; $n)