//%attributes = {}
// Calc Sterling ( Annalized compounded return; Worst Drawdown ) -> Real
// Sterling = rp/dd


C_REAL:C285($result; $1; $2; $0)

$result:=($1/$2)  // this result is an ABSOLUTE value.

$0:=Round:C94($result; <>round)

