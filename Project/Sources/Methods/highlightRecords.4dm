//%attributes = {}
// highlightREcords(->table)
// highlights the current selection of records in table
// PRE: Multiple selection option must be ON for the subtable
C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($set)
$tablePtr:=$1
$set:="$"+Table name:C256($tablePtr)
CREATE SET:C116($tablePtr->; $set)
HIGHLIGHT RECORDS:C656($tablePtr->; $set)
CLEAR SET:C117($set)