//%attributes = {}
// calcSafeDivide( a; b ) -> a/b
// returns a/b (b≠0)

C_REAL:C285($1; $2; $3; $0)

If ($2#0)
	$0:=$1/$2
Else 
	If (Count parameters:C259=3)
		$0:=$3
	Else 
		$0:=0
	End if 
End if 
