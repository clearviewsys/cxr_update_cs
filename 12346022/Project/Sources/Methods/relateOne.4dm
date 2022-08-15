//%attributes = {}
// relateOne (->oneTable; ->ManyTableField; ->oneTableField)
// acts like relate one, except that it doesn't require a relation
// 

C_POINTER:C301($1; $2; $3)

READ ONLY:C145($1->)
QUERY:C277($1->; $3->=$2->)

If (Records in selection:C76($1->)=1)  // one record found, then fix the manyfield
	$2->:=$3->
End if 