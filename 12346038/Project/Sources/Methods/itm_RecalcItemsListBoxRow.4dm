//%attributes = {}
// call this method to do calculations on the row

C_LONGINT:C283($i; $1)
$i:=$1

If (False:C215)
	ARRAY REAL:C219(arrBalances; 0)
	ARRAY REAL:C219(arrIns; 0)
	ARRAY REAL:C219(arrOuts; 0)
	ARRAY REAL:C219(arrDebitBalances; 0)
	ARRAY REAL:C219(arrDebits; 0)
	ARRAY REAL:C219(arrCredits; 0)
	
	ARRAY REAL:C219(arrCOGS; 0)
	ARRAY REAL:C219(arrProfits; 0)
End if 

arrBalances{$i}:=arrIns{$i}-arrOuts{$i}
//arrDebitBalances{$i}:=itm_arrDebits{$i}-itm_arrCredits{$i}