//%attributes = {}
// showFlaggedTable(->[TABLE];->flaggedField)

C_POINTER:C301($tablePtr; $flagFieldPtr; $1; $2)

$tablePtr:=$1
$flagFieldPtr:=$2

READ ONLY:C145($tablePtr->)
QUERY:C277($tablePtr->; $flagFieldPtr->=True:C214)
orderByTable($tablePtr)