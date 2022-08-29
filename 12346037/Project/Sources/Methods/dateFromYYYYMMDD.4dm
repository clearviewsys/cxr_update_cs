//%attributes = {}
// converts date in YYYY-MM-DD format to 4D Date value

C_DATE:C307($0)
C_TEXT:C284($1; $YYYYMMDD)  //Expects YYYY-MM-DD format

$YYYYMMDD:=$1
$0:=!00-00-00!

C_LONGINT:C283($d; $m; $y)

If (Length:C16($YYYYMMDD)=10)
	
	$y:=Num:C11(Substring:C12($YYYYMMDD; 1; 4))
	$m:=Num:C11(Substring:C12($YYYYMMDD; 6; 2))
	$d:=Num:C11(Substring:C12($YYYYMMDD; 9; 2))
	
	$0:=Add to date:C393($0; $y; $m; $d)
	
End if 
