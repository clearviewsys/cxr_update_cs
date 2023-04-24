//%attributes = {}
// calcMin(real1;real2) -> returns the maximum of real1 and real2
// Unit test written @ Marko

C_REAL:C285($1; $2; $0)
If ($1<$2)
	$0:=$1
Else 
	$0:=$2
End if 
