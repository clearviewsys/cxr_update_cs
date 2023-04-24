//%attributes = {}
// getButtonGridClickRC (self; totalColumns; ->row;->col)
C_POINTER:C301($1; $3; $4; $buttonGridPtr; $rowPtr; $colPtr)
C_LONGINT:C283($2; $columns; $n)
$buttonGridPtr:=$1
$columns:=$2
$rowPtr:=$3
$colPtr:=$4
$n:=$buttonGridPtr->
$rowPtr->:=($n\$columns)+1
$colPtr->:=($n%$columns)
