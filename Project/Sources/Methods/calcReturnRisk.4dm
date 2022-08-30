//%attributes = {}
// Calc ReturnRisk(  Rp ; Stdp ) ->Real
// Rp: Compounded Return of portfolio
// Stdp: Annualized Standard deviation of portfolio
// return/risk = Rp/Stdp

C_REAL:C285($1; $2; $0; $result)

//$0:=Round($result;◊round)
$0:=($1/$2)
