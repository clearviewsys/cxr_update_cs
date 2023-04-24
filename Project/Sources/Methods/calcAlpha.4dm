//%attributes = {}
// Calc Alpha (rp,rm,rf, Bp) -> Real
// Calculates the Jensen's Measure
// rp: Return of portfolio
// rm: Return of Market or Index
// rf: Risk Free Rate

C_REAL:C285($result; $1; $2; $3; $4; $0)
C_REAL:C285($rp; $rm; $rf; $Bp)

$rp:=$1
$rm:=$2
$rf:=$3
$Bp:=$4

$result:=$rp-($rf+($Bp*($rm-$rf)))
//$0:=Round($result;◊round)
$0:=$result
