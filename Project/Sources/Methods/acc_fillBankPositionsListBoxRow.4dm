//%attributes = {}
// acc_fillAccountsListBoxRow (row;currency)
// PRE: arrCurrencies{$} must already be filled

C_LONGINT:C283($row; $1)
$row:=$1
C_TEXT:C284($currency; $2)
$currency:=$2

If (False:C215)  // for compiler's sake)
	ARRAY TEXT:C222(arrAccountIDs; 0)
	ARRAY REAL:C219(arrOpenings; 0)
	ARRAY REAL:C219(arrTransferIns; 0)
	ARRAY REAL:C219(arrTransferOuts; 0)
	ARRAY REAL:C219(arrBought; 0)
	ARRAY REAL:C219(arrSold; 0)
	ARRAY REAL:C219(arrBalances; 0)
	ARRAY TEXT:C222(arrCurrencies; 0)
	ARRAY REAL:C219(arrDebits; 0)
	ARRAY REAL:C219(arrCredits; 0)
	ARRAY REAL:C219(arrAvgBuyRates; 0)
	ARRAY REAL:C219(arrAvgSellRates; 0)
	ARRAY REAL:C219(arrMarketValues; 0)
	ARRAY TEXT:C222(arrRemarks; 0)
	
End if 

arrCurrencies{$row}:=$currency
arrAccountIDs{$row}:="Bank-"+($currency)

C_POINTER:C301($p2; $p3; $p4; $p5; $p6; $p7; $p8; $p9; $p10; $p11)
$p2:=->arrOpenings{$row}
$p3:=->arrTransferIns{$row}
$p4:=->arrTransferOuts{$row}
$p5:=->arrBought{$row}
$p6:=->arrSold{$row}
$p7:=->arrBalances{$row}
$p8:=->arrDebits{$row}
$p9:=->arrCredits{$row}
$p10:=->arrAvgBuyRates{$row}
$p11:=->arrAvgSellRates{$row}

calcBankPositionsForCurrency($currency; $p2; $p3; $p4; $p5; $p6; $p7; $p8; $p9; $p10; $p11)
