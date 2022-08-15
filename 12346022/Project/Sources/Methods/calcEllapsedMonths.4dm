//%attributes = {}
//Calc ellapsed months (Date 1; Date 2)

C_LONGINT:C283($first; $second; $0)
C_DATE:C307($1; $2)

$first:=Month of:C24($1)+(Year of:C25($1)*12)
$second:=Month of:C24($2)+(Year of:C25($2)*12)
$0:=Abs:C99($second-$first)

