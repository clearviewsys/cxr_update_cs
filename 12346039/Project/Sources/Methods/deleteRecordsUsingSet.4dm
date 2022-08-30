//%attributes = {}
// deleteRecords(->table;highlightedSetName)

// Mehtod to call when multiple or single $highlightedSet are to be deleted

C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($2; $originalSet)
C_TEXT:C284($setName)

$tablePtr:=$1
$originalSet:=$2
$setName:=Table name:C256($tablePtr)+"HilitedSet"


CREATE SET:C116($tablePtr->; $setName)
DELETE SELECTION:C66($tablePtr->)  // delete the selected records
DIFFERENCE:C122($originalSet; $setName; $originalSet)  // take off the $highlightedSet from the original set
USE SET:C118($originalSet)  // 
CLEAR SET:C117($setName)