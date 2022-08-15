//%attributes = {}
//setListBoxFocusedRow (->columnArray; ->value)

C_POINTER:C301($1; $2; $columnArrayPtr; $columnPtr; $valuePtr)
C_LONGINT:C283($row)
$ColumnPtr:=Focus object:C278
$columnArrayPtr:=$1
$valuePtr:=$2

// $Column contains a pointer to col2
$Row:=$ColumnPtr->  //$Row equals 5
$columnArrayPtr->{$row}:=$valuePtr->