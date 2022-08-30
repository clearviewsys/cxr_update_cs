//%attributes = {}
//calcApplyPCT (amount;pct; {rounddigit})

C_REAL:C285($0; $1; $2)
C_LONGINT:C283($3)

$0:=$1*(1+($2/100))

If (Count parameters:C259=3)
	$0:=Round:C94($0; $3)
End if 
