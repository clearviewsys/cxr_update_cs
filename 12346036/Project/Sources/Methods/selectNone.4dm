//%attributes = {}
//selectNone(->[TABLE];->anyStringFieldPtr)

C_POINTER:C301($1; $tableptr)
$tablePtr:=$1

REDUCE SELECTION:C351($tableptr->; 0)
