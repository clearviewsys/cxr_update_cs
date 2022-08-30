//%attributes = {}
// countRelatedManySelection (->manyField)

// this method counts the number of records in the many table that are connected to the one table


C_POINTER:C301($1; $manyTablePtr; $manyFieldPtr)
C_LONGINT:C283($0; $result)
$manyTablePtr:=$1
$manyFieldPtr:=$2

SET QUERY DESTINATION:C396(Into variable:K19:4; $result)

RELATE MANY SELECTION:C340($manyFieldPtr->)
// The following trivial query is to trigger the counting because a relate many would not be considered a query

// and therefore it won't affect the $result

QUERY SELECTION:C341($manyTablePtr->; $manyFieldPtr->#"")

$0:=$result
SET QUERY DESTINATION:C396(Into current selection:K19:1)