//%attributes = {"publishedWeb":true}
// ShowRecord (»TABLE, recordNumber:string)

// this is for ADS table only


// show the current record only in HTML form


C_TEXT:C284($2)
C_POINTER:C301($1)
GOTO RECORD:C242($1->; Num:C11(Substring:C12($2; 2; 99)))
SetVariablesToFields($1)
//LOAD RECORD($1->)

WEB SEND FILE:C619(Table name:C256($1)+"Modify.html")

