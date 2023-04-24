//%attributes = {}
// vCalcBeta(->fundPCTArrays;->BM_PCTArrays)

// Beta = Covar(market,fund)/var(market)

C_POINTER:C301($1; $2)
C_REAL:C285($0)

$0:=vCalcCovar($1; $2)/vCalcVar($2)
