//%attributes = {}
// relateMany (->manyTable;->manyTableField;->oneField)
// why use this method instead of 4D relate many
// when there are no line relation between the fields of the two tables
// 

C_POINTER:C301($1; $2; $3)
READ ONLY:C145($1->)
QUERY:C277($1->; $2->=$3->)
