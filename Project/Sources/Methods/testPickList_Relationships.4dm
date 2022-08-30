//%attributes = {}

C_TEXT:C284($relation)
//$relation:="Cousin"

pickRelationship(->$relation; False:C215)  // will open anyways because $relation is still empty

myAlert($relation)  // $relation will have a value (the picked value)

pickRelationship(->$relation; False:C215)  // should not open again

pickRelationship(->$relation; True:C214)  // should open again


