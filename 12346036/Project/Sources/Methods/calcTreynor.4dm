//%attributes = {}
// calcTreynor(alpha,beta)
// treynor = alpha/beta

C_REAL:C285($1; $2; $0)
If ($2#0)
	$0:=$1/$2
Else 
	$0:=0
End if 
