//%attributes = {}
// fillArrayTableNamesAndNumbers (->tablesNumbers ;->tableNames)


C_LONGINT:C283($n; $i)
$n:=Get last table number:C254
ARRAY INTEGER:C220($1->; $n+1)
ARRAY TEXT:C222($2->; $n+1)

For ($i; 1; $n)
	If (Is table number valid:C999($i))  // Modified by: Barclay (3/5/2012)- added
		$1->{$i}:=$i
		$2->{$i}:=Table name:C256($i)
	End if 
End for 

$1->{$n+1}:=0
$2->{$n+1}:="***Default Privilege"