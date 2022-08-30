//%attributes = {}
C_TEXT:C284($1; $0)
C_DATE:C307($2)

$0:=$1+String:C10(convDate2Serial($2))  //concatenate the account and the date to create a compound index