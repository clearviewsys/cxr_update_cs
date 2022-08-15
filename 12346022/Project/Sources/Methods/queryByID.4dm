//%attributes = {}
// queryByID (->table;ID)

// queries on the first field of table


C_POINTER:C301($1)
C_TEXT:C284($2)

C_LONGINT:C283($tableNum)
$tableNum:=Table:C252($1)
READ ONLY:C145($1->)
QUERY:C277($1->; Field:C253($tableNum; 1)->=$2)  // look for the related 

