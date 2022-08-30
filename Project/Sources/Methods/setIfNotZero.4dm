//%attributes = {}
// setIfNotZero (->varPtr;value)
// assigns the varPtr-> to value only if the value is not zero

C_POINTER:C301($1)
C_REAL:C285($2)

If ($2#0)
	$1->:=$2
End if 