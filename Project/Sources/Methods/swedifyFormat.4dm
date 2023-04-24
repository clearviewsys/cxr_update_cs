//%attributes = {}
// swedifyFormat(number) -> string 
// returns a string in swedish number format

C_REAL:C285($num; $1)
C_TEXT:C284($str; $0)

Case of 
	: (Count parameters:C259=0)
		$num:=-1487.81
	Else 
		$num:=$1
End case 

If ($num<0)
	$num:=-$num
	$str:="-"+String:C10(Int:C8($num))+","+String:C10(Dec:C9($num)*100; "00")
	
Else 
	$str:=String:C10(Int:C8($num))+","+String:C10(Dec:C9($num)*100; "00")
	
End if 
$0:=$str