//%attributes = {}

C_POINTER:C301($tablePtr; $flagFieldPtr; $1; $2)

$tablePtr:=$1
$flagFieldPtr:=$2
toggleBooleanField($tablePtr; $flagFieldPtr)