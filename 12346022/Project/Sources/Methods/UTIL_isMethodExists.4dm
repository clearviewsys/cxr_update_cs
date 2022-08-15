//%attributes = {}


C_TEXT:C284($1)

C_BOOLEAN:C305($0)

ARRAY TEXT:C222($arrNames; 0)

METHOD GET NAMES:C1166($arrNames; $1; *)

$0:=(Size of array:C274($arrNames)>0)
// -> True if method exists