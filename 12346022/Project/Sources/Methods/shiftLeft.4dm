//%attributes = {}
// shiftLeft (->var)

C_POINTER:C301($1; $objPtr)
$objPtr:=$1

If ((Not:C34(Is nil pointer:C315($objPtr))) & (Type:C295($objPtr->)=Is real:K8:4))
	C_REAL:C285($n)
	C_LONGINT:C283($len)
	$n:=$objPtr->
	If (Int:C8($n)#$n)  // has decimal digits
		$len:=calcMax(Length:C16(String:C10($n)); 1)
		$n:=Num:C11(Substring:C12(String:C10($n); 1; $len-1))
		$objPtr->:=$n
		BEEP:C151
	Else   // is an integer value 
		$n:=Int:C8($n/10)*10
		$objPtr->:=$n
	End if 
End if 