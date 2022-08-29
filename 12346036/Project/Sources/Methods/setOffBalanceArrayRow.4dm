//%attributes = {}
// setOffBalanceArrayRow(row)
C_LONGINT:C283($row; $1)
$row:=$1

arrOffBalances{$row}:=arrAdjustedBalances{$row}-arrAccountBalances{$row}
arrOffBalancesLC{$row}:=arrOffBalances{$row}*arrRates{$row}
