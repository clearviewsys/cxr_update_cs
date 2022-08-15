//%attributes = {}
// Ratexify (number) -> returns a string
C_REAL:C285($1; $num)
C_TEXT:C284($0)

C_TEXT:C284($str; $placeholder)
C_LONGINT:C283($n)

Case of 
	: (Count parameters:C259=1)
		$num:=$1
	Else 
		$num:=0
End case 
$placeholder:="_______"

If ($num>0)
	$str:=$placeholder+Substring:C12(String:C10($num); 1; 7)
	$n:=Length:C16($str)
	$str:=Char:C90(Double quote:K15:41)+Substring:C12($str; $n-6; 7)+Char:C90(Double quote:K15:41)
Else 
	$str:=Quotify($placeholder)
End if 
$0:=$str


