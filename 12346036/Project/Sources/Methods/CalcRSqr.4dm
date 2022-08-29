//%attributes = {}
// Calc RSqr (Beta; var(p) ; var(m)) -> Real
// var(P): variance or std^2  of portfolio
// var(m): variance or std^2 of market


C_REAL:C285($result; $1; $2; $3; $0)


$result:=(($1^2)*$2)/$3

//$0:=Round($result;◊round)
$0:=$result*100
