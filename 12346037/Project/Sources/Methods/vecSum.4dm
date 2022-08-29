//%attributes = {}
// vecSum (-> vector) -> real

// vector summing of real values


C_POINTER:C301($1)
C_REAL:C285($0; $sum)
C_LONGINT:C283($i)

$sum:=0

//For ($i;1;Size of array($1->))
//$sum:=$sum+$1->{$i}
//End for 

$0:=Sum:C1($1->)  // new in version 13.1
