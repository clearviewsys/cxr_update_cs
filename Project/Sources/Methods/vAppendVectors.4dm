//%attributes = {"publishedWeb":true}
// vAppendVectors(->v1;->v2;->v3)
// this methods appends two real arrays and return it in the third one

C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($n1; $n2; $n3)
C_LONGINT:C283($i)

$n1:=Size of array:C274($1->)
$n2:=Size of array:C274($2->)
$n3:=$n1+$n2

COPY ARRAY:C226($1->; $3->)  // copy the first array
ARRAY REAL:C219($3->; $n3)  // resize array to hold the second part

For ($i; 1; $n2)
	$3->{$n1+$i}:=$2->{$i}
End for 
