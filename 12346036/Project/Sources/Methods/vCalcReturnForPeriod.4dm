//%attributes = {}
// vCalcReturnForPeriod(->DatesBOM;->BOMNAVs;->EOMNAVs;$fromDate;$toDate) -> returnPctChange
// This method calculates the percent change between two dates
// PRE: all the arrays are equal size and all sorted by date

C_POINTER:C301($1; $2; $3; $datesPtr; $BOMPtr; $EOMPtr)
C_DATE:C307($4; $5; $fromDate; $toDate)
C_REAL:C285($0)

$datesPtr:=$1
$BOMPtr:=$2
$EOMPtr:=$3
$fromDate:=calcBOMonth($4)
$toDate:=calcBOMonth($5)

C_LONGINT:C283($n; $i; $j)
$n:=Size of array:C274($datesPtr->)


C_REAL:C285($firstNV; $lastNV)
$i:=Find in array:C230($datesPtr->; $fromDate)  // row number for the first date
$j:=Find in array:C230($datesPtr->; $toDate)  // row number for the last date

$firstNV:=$BOMPtr->{$i}  // find the first NV value
$lastNV:=$EOMPtr->{$j}  // find the second NV value

$0:=calcPctChange($firstNV; $lastNV)
