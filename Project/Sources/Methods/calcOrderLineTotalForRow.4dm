//%attributes = {}
// calcTellerProofTotalForRow(row)
C_LONGINT:C283($row; $1)
$row:=$1

arrTotals{$row}:=arrDenoms{$row}*arrQty{$row}

