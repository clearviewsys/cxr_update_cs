//%attributes = {}
//Calc pct change (old;new) 
C_REAL:C285($1; $2; $0; $old; $new; $result)
$old:=$1
$new:=$2

If ($1#0)
	$result:=(calcSafeDivide($new; $old)-1)*100
Else 
	$result:=0
End if 

$0:=$result