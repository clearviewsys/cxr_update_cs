//%attributes = {}
// call this method to recalculate the row
If (False:C215)
	ARRAY REAL:C219(acc_arrMarketValues; 0)
	ARRAY REAL:C219(acc_arrBalances; 0)
	ARRAY REAL:C219(acc_arrMarketRates; 0)
End if 

C_LONGINT:C283($i; $1)
$i:=$1
acc_arrMarketValues{$i}:=roundToBase(acc_arrMarketRates{$i}*acc_arrBalances{$i})
