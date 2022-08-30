//%attributes = {}
// webBSearch(->table;->field1...>field7)

C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8)
C_TEXT:C284(webSearchField)

QUERY:C277($1->; $2->="@"+webSearchField+"@"; *)
QUERY:C277($1->;  | ; $3->="@"+webSearchField+"@"; *)
QUERY:C277($1->;  | ; $4->="@"+webSearchField+"@"; *)
QUERY:C277($1->;  | ; $5->="@"+webSearchField+"@"; *)
QUERY:C277($1->;  | ; $6->="@"+webSearchField+"@"; *)
QUERY:C277($1->;  | ; $7->="@"+webSearchField+"@"; *)
QUERY:C277($1->;  | ; $8->="@"+webSearchField+"@")

