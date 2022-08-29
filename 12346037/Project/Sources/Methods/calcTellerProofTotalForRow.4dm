//%attributes = {}
// calcTellerProofTotalForRow(row)
C_LONGINT:C283($row; $1)
$row:=$1

arrTotalQtys{$row}:=arrQty1{$row}+arrQty2{$row}
arrTotals{$row}:=arrDenoms{$row}*arrTotalQtys{$row}

