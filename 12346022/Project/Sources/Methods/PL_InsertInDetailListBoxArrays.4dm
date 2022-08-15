//%attributes = {}
// InsertInDetailListBoxArrays ( m ; n)
// m: where to insert
// n: how many to insert


C_LONGINT:C283($m; $n; $1; $2)

Case of 
	: (Count parameters:C259=1)
		$m:=$1
		$n:=1
	: (Count parameters:C259=2)
		$m:=$1
		$n:=$2
	Else 
		$m:=1
		$n:=1
End case 

INSERT IN ARRAY:C227(ARRREGISTERIDS; $m; $n)
INSERT IN ARRAY:C227(ARRDATES; $m; $n)
INSERT IN ARRAY:C227(arrDebits; $m; $n)
INSERT IN ARRAY:C227(arrCredits; $m; $n)
INSERT IN ARRAY:C227(arrRates; $m; $n)
INSERT IN ARRAY:C227(arrInventory; $m; $n)
INSERT IN ARRAY:C227(arrProfits; $m; $n)
INSERT IN ARRAY:C227(arrAvgBuyRates; $m; $n)
INSERT IN ARRAY:C227(arrShortRates; $m; $n)
INSERT IN ARRAY:C227(ARRDEBITLOCALS; $m; $n)
INSERT IN ARRAY:C227(ARRCREDITLOCALS; $m; $n)
INSERT IN ARRAY:C227(ARRFEES; $m; $n)
INSERT IN ARRAY:C227(arrCOGS; $m; $n)
INSERT IN ARRAY:C227(arrNets; $m; $n)