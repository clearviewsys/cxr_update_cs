C_OBJECT:C1216($filterObj; $dateRange)
C_BOOLEAN:C305($applyDateRange; $isConnected)
C_POINTER:C301($fromDatePtr; $toDatePtr; $applyDateRangePtr)

ErrorTrap
$filterObj:=newAML_AggrRuleFilter([Customers:3]CustomerID:1)

$fromDatePtr:=OBJECT Get pointer:C1124(Object named:K67:5; "fromDate")
$toDatePtr:=OBJECT Get pointer:C1124(Object named:K67:5; "toDate")
$applyDateRangePtr:=OBJECT Get pointer:C1124(Object named:K67:5; "applyDateRange")

$applyDateRange:=numToBoolean($applyDateRangePtr->)
$isConnected:=numToBoolean(OBJECT Get pointer:C1124(Object named:K67:5; "applyConnected")->)
$dateRange:=newDateRange($fromDatePtr->; $toDatePtr->; $applyDateRange)

Form:C1466.stats:=getTransactionStats($filterObj; $dateRange; True:C214; $isConnected)
endErrorTrap
