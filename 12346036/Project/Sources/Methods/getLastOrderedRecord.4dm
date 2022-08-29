//%attributes = {}
// getLastOrderedRecord(->[table];->field;->result)

// this method retunrs the last element of the ordered table by field

// for example can be used to get the last invoice number


C_POINTER:C301($1; $tablePtr; $2; $fieldPtr; $3; $destinationPtr)

$tablePtr:=$1
$fieldPtr:=$2
$destinationPtr:=$3

READ ONLY:C145($tablePtr->)
ALL RECORDS:C47($tablePtr->)
ORDER BY:C49($TablePtr->; $fieldPtr->; >)
LAST RECORD:C200($tablePtr->)
$destinationPtr->:=$fieldPtr->  // return the last element