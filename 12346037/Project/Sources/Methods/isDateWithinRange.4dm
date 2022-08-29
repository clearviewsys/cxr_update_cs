//%attributes = {}
C_BOOLEAN:C305($0)

C_DATE:C307($date; $1)
C_LONGINT:C283($n; $2)

$date:=$1
$n:=$2

C_LONGINT:C283($n1; $n2; $diff)

//$n1:=Month of(Current date)*100+Day of(Current date)
//$n2:=Month of($date)*100+Day of($date)
//$diff:=$n2-$n1
//
//If (($diff>0) & ($diff<=$n))
//$0:=True
//Else 
//$0:=False
//End if 

C_DATE:C307($date2; $currentDate)

$currentDate:=Current date:C33

If ($currentDate>$date) & ($date>!00-00-00!)
	$date2:=Date:C102(String:C10(Month of:C24($date))+"/"+String:C10(Day of:C23($date))+"/"+String:C10(Year of:C25($currentDate)))
	$diff:=$date2-$currentDate
	If (($date2-$currentDate)<=$n) & ($diff>0)
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
Else 
	$0:=False:C215
End if 