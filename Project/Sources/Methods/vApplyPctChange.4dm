//%attributes = {"publishedWeb":true}
// vApplyPCTChange (startValue; ->%changeVector;->result)
// % changeVector elements are real values 25 means 25%
// a value .2 means .2% so the division by 100 is not done
// v(i)=v(i-1)*(1+r(i-1)/100)

C_REAL:C285($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_LONGINT:C283($i)
C_LONGINT:C283($n)
$n:=Size of array:C274($2->)
If ($n>0)
	ARRAY REAL:C219($3->; $n)  // resize the result array
	
	$3->{1}:=$1
	For ($i; 2; $n)
		$3->{$i}:=calcApplyPCT(($3->{$i-1}); $2->{$i-1})
	End for 
	// I store the last Value in element zero of the array
	$3->{0}:=calcApplyPCT(($3->{$n}); $2->{$n})
End if 
