//%attributes = {}
//swapStrings(->str1;->str2)
// this method swaps the value of two strings

C_POINTER:C301($1; $2; $strPtr1; $strPtr2)
$strPtr1:=$1
$strPtr2:=$2

C_TEXT:C284($tempStr)

$tempStr:=$strPtr1->
$strPtr1->:=$strPtr2->
$strPtr2->:=$tempStr
