//%attributes = {}
// newAML_Alert( subject; description;tableNo; reco)

C_POINTER:C301($tablePtr)
$tablePtr:=->[AML_Alerts:137]



READ WRITE:C146($tablePtr->)
CREATE RECORD:C68($tablePtr->)