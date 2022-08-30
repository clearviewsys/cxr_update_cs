//%attributes = {"publishedWeb":true}
// vFillCommonDates(->dateArray1;->dateArray2;->resultArray)
// PRE: dates should increase on a monthly basis
// PRE: both arrays must contain at least one item

C_POINTER:C301($1; $2; $3)
C_POINTER:C301($dateArrayPtr1; $dateArrayPtr2; $dateArrayPtr3; $resultArrayPtr)
C_DATE:C307($startDate1; $startDate2; $endDate1; $endDate2; $commonStartDate; $commonEndDate)
C_LONGINT:C283($n1; $n2; $n)

$dateArrayPtr1:=$1
$dateArrayPtr2:=$2
$dateArrayPtr3:=$3

$startDate1:=$dateArrayPtr1->{1}  // starting dates
$startDate2:=$dateArrayPtr2->{1}  //
$n1:=Size of array:C274($dateArrayPtr1->)  // lenght of arrays
$n2:=Size of array:C274($dateArrayPtr2->)  //
$endDate1:=$dateArrayPtr1->{$n1}  // ending dates
$endDate2:=$dateArrayPtr1->{$n2}  //

$commonStartDate:=calcMaxDate($startDate1; $startDate2)  // find the common starting date
$commonEndDate:=calcMinDate($endDate1; $endDate2)  // find the common ending date
$n:=calcEllapsedMonths($commonStartDate; $commonEndDate)  // number of months between start and end

ARRAY DATE:C224($dateArrayPtr3->; $n)
vFillDates($dateArrayPtr3; $commonStartDate; 0; 1; 0)  // fill the array 1 month at a time