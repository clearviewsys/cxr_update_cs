//%attributes = {}
// Profix expects . as decimal separator

C_REAL:C285($1)
C_TEXT:C284($0)

$0:=String:C10(Int:C8($1))
$0:=$0+"."+String:C10(Int:C8(100*Dec:C9($1)))
