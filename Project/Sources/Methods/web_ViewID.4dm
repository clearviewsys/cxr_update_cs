//%attributes = {}
// webViewID(->table;->IDField;->IDValue)



C_TEXT:C284($3)
C_POINTER:C301($1; $2)
QUERY:C277($1->; $2->=Substring:C12($3; 2; 99))

SetVariablesToFields($1)
web_SendHTMLPage($1; "View")
