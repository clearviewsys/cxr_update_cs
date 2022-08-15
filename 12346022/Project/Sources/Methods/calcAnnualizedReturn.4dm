//%attributes = {}
// Calc Annual Return (NAV1;NAV2;N) -> Real
// Calculate the coumpound Annualized Return

// N is the number of months

C_REAL:C285($return; $NAV1; $NAV2; $N; $1; $2; $3; $0)

$NAV1:=$1
$NAV2:=$2
$N:=$3

$return:=(($NAV2/$NAV1)^(12/$N)-1)*100
$0:=Round:C94($return; <>round)

