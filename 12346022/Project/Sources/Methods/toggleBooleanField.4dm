//%attributes = {}
// toggleBooleanField (->[TABLE];->[boolean FIELD])

C_POINTER:C301($1; $tablePtr; $2; $booleanFieldPtr)
$tablePtr:=$1
$booleanFieldPtr:=$2

addToTableFavorite($tablePtr; $booleanFieldPtr)
