//%attributes = {}
// countRelatedOneSelection (->manytable;->manyFieldPtr;->oneTablePtr;->oneFieldPtr)

// this method counts the number of records in the one table based on the selection on the many table


C_POINTER:C301($1; $manyTablePtr; $oneTablePtr; $oneFieldPtr; $manyFieldPtr; $4; $2; $3)
C_LONGINT:C283($0; $result)
$manyTablePtr:=$1
$manyFieldPtr:=$2
$oneTablePtr:=$3
$oneFieldPtr:=$4

SET QUERY DESTINATION:C396(Into variable:K19:4; $result)
relateOneSelection($manyTablePtr; $manyFieldPtr; $oneTablePtr)
//RELATE ONE SELECTION($manyTablePtr->;$oneTablePtr->)

// The following trivial query is to trigger the counting because a relate many would not be considered a query

// and therefore it won't affect the $result

QUERY SELECTION:C341($oneTablePtr->; $oneFieldPtr->#"")

$0:=$result
SET QUERY DESTINATION:C396(Into current selection:K19:1)