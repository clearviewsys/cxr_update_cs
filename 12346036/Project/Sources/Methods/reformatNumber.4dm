//%attributes = {"publishedWeb":true}
// reformatNumber

// this method must be called from 

C_TEXT:C284($0; $1)
C_REAL:C285($number)
C_POINTER:C301($varPtr)
$varPtr:=Get pointer:C304(Substring:C12($1; 2))

$number:=Num:C11($varPtr->)
$0:=String:C10($number; "|Currency (blank for 0)")
