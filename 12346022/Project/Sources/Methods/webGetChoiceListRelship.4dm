//%attributes = {"shared":true}




C_POINTER:C301($1)  //option - pointer to array to fill
C_POINTER:C301($2)  //option value
C_POINTER:C301($3)  //option label




ALL RECORDS:C47([List_Relationships:136])

ORDER BY:C49([List_Relationships:136]; [List_Relationships:136]Relationship:2; >)
SELECTION TO ARRAY:C260([List_Relationships:136]Relationship:2; $1->)
SELECTION TO ARRAY:C260([List_Relationships:136]Relationship:2; $2->)
//SELECTION TO ARRAY([RelationTypes]relationTypeID;$2->)

INSERT IN ARRAY:C227($1->; 1)
$1->{1}:="-Select an Relationship Type-"
INSERT IN ARRAY:C227($2->; 1)
$2->{1}:=""