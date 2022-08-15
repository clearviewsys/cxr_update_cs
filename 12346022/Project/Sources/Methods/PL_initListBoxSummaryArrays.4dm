//%attributes = {}
C_LONGINT:C283($n; $1)

Case of 
	: (Count parameters:C259=0)
		$n:=0
	Else 
		$n:=$1
End case 

//ARRAY PICTURE(ARRFLAGS;$n)
ARRAY TEXT:C222(arrCurrencies; $n)
ARRAY REAL:C219(ARROPENINGS; $n)
ARRAY REAL:C219(arrBuys; $n)
ARRAY REAL:C219(arrSells; $n)
ARRAY REAL:C219(arrBalances; $n)
ARRAY REAL:C219(arrBuyRates; $n)
//ARRAY REAL(arrSellRates;$n)
ARRAY REAL:C219(ARRINVENTORYCOSTS; $n)
ARRAY REAL:C219(ARRREVENUES; $n)
ARRAY REAL:C219(arrTotalProfits; $n)
ARRAY REAL:C219(arrTotalFees; $n)
ARRAY REAL:C219(arrSumCOGS; $n)
ARRAY REAL:C219(ARRNETPROFITS; $n)
ARRAY REAL:C219(arrInventoryValueLC; $n)