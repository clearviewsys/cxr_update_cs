setDateRangeVars(Current date:C33; Current date:C33; True:C214)
C_POINTER:C301($tablePtr; $dateFieldPtr)
$tablePtr:=getAMLDashboardTabTablePtr
$dateFieldPtr:=getTableDateFieldPtr($tablePtr)

showTodaysTable($tablePtr; $dateFieldPtr)