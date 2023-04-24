//%attributes = {"publishedWeb":true}
// ShowRecord (»TABLE, recordNumber:string)

// this is for ADS table only


// show the current record only in HTML form


C_TEXT:C284($2)
C_POINTER:C301($1)
GOTO RECORD:C242($1->; Num:C11(Substring:C12($2; 2; 99)))

SetVariablesToFields($1)
web_SendHTMLPage($1; "View")

