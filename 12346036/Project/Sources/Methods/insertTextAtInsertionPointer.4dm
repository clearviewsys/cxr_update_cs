//%attributes = {}
// insertTextAtInsertionPointer (->source; textToInsert)
//  WARNING : make sure that the button that calls this is not "FOCUSABLE" otherwise you will lose the insertion point


C_POINTER:C301($1; $fieldPtr)
C_TEXT:C284($2; $textToInsert)

$fieldPtr:=$1
$textToInsert:=$2


C_LONGINT:C283($First; $Last)
GET HIGHLIGHT:C209($fieldPtr->; $First; $Last)
$fieldPtr->:=Insert string:C231($fieldPtr->; $textToInsert; $first)
HIGHLIGHT TEXT:C210($fieldPtr->; $first; Length:C16($textToInsert)+$first)