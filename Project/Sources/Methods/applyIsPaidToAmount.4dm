//%attributes = {}
// applyIsPaidToAmount (Amount;isPaid)
// this method returns a negative or positive number depening on the isPaid
C_REAL:C285($1; $0)
C_BOOLEAN:C305($2)

If ($2)
	$0:=$1*-1
Else 
	$0:=$1
End if 