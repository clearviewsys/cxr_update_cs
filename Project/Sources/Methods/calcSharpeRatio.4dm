//%attributes = {}
// Calc SharpeRatio ( rp ; rf ; sp )

// rp : return of portfolio (fund)
// rf: Risk Free Rate (given constant could be ◊RiskFreeRate)
// sp: standard deviation of portfolio (fund)

//NOTE : Sharpe depends on Stdev and Return of Portfolio

C_REAL:C285($0; $1; $2; $3; $result)

$result:=($1-$2)/$3

$0:=Round:C94($result; <>round)


