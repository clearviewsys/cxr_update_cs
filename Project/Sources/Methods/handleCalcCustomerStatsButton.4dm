//%attributes = {}
// handleCustomerStatsButton
// this method is called from the Customer.View page
// PRE: requires some objects on the form called fromDate ; toDate ; applyDateRange and ApplyConnected
// POST: it will post the results to Form.stats

C_OBJECT:C1216($filterObj; $dateRange)
C_BOOLEAN:C305($applyDateRange; $isConnected)
C_POINTER:C301($fromDatePtr; $toDatePtr; $applyDateRangePtr)

ErrorTrap
$filterObj:=agg_newFilterFromForm([Customers:3]CustomerID:1)

$fromDatePtr:=OBJECT Get pointer:C1124(Object named:K67:5; "fromDate")
$toDatePtr:=OBJECT Get pointer:C1124(Object named:K67:5; "toDate")
$applyDateRangePtr:=OBJECT Get pointer:C1124(Object named:K67:5; "applyDateRange")

$applyDateRange:=numToBoolean($applyDateRangePtr->)
$isConnected:=numToBoolean(OBJECT Get pointer:C1124(Object named:K67:5; "applyConnected")->)
$dateRange:=newDateRange($fromDatePtr->; $toDatePtr->; $applyDateRange)

Form:C1466.stats:=agg_getStatsObject($filterObj; $dateRange; True:C214; $isConnected)
endErrorTrap
