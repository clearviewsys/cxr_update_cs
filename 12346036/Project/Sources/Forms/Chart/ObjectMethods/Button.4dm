C_POINTER:C301($graphPtr)
C_LONGINT:C283($n; $i)
$n:=15

ARRAY LONGINT:C221($arrX; $n)
ARRAY REAL:C219($arrY; $n)
$graphPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "graph")

For ($i; 1; $n)
	$arrX{$i}:=$i
	$arrY{$i}:=20*Sin:C17($i)
End for 


drawBarChart($graphPtr; ->$arrX; ->$arrY)