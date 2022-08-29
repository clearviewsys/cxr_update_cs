//%attributes = {}
// relateOneSelection (->[ManyTable] ;->manyFieldPtr;->[oneTable] )

// the reason I had to write this method is for an unknown reason 

// sometimes the 4D method 'RELATE ONE SELECTION' doesn't work

// at least when there are complex relationships between tables


C_POINTER:C301($1; $manyTablePtr; $oneTablePtr; $2; $manyFieldPtr; $3)
$manyTablePtr:=$1
$manyFieldPtr:=$2
$oneTablePtr:=$3


CREATE EMPTY SET:C140($oneTablePtr->; "relatedOneSelection")
READ ONLY:C145($oneTablePtr->)
FIRST RECORD:C50($manyTablePtr->)

While (Not:C34(End selection:C36($manyTablePtr->)))
	RELATE ONE:C42($manyFieldPtr->)
	ADD TO SET:C119($oneTablePtr->; "relatedOneSelection")
	NEXT RECORD:C51($manyTablePtr->)
End while 
USE SET:C118("relatedOneSelection")
CLEAR SET:C117("relatedOneSelection")