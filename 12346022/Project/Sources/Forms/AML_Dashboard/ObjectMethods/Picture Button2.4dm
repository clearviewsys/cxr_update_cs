C_LONGINT:C283(cbApplyDateRange)
requestDateRange
cbApplyDateRange:=1
C_POINTER:C301($tablePtr; $dateFieldPtr)
$tablePtr:=getAMLDashboardTabTablePtr
$dateFieldPtr:=getTableDateFieldPtr($tablePtr)
showDateRangeTable($tablePtr; $dateFieldPtr)