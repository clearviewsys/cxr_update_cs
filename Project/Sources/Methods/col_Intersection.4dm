//%attributes = {}
// col_Intersection ( $colA; $colB  ) --> col  [ items in col1 that are ALSO in col2 ]

C_COLLECTION:C1488($1; $colA)
C_COLLECTION:C1488($2; $colB)
C_COLLECTION:C1488($0; $colResult)

$colA:=$1
$colB:=$2

If ($colA=Null:C1517)
	$colA:=New collection:C1472
End if 

If ($colB=Null:C1517)
	$colB:=New collection:C1472
End if 

$colResult:=$colA.filter("filterCollection"; $colB; True:C214)

$0:=$colResult
