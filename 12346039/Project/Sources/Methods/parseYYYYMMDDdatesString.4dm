//%attributes = {}
// parseYYYY/MM/DD (string) -> date
// send me a string in YYYY/MM/DD format and i'll send you the date

C_TEXT:C284($dateStr; $yearStr; $monthStr; $dayStr; $1)
C_DATE:C307($date; $0)

Case of 
	: (Count parameters:C259=1)
		$dateStr:=$1
	Else 
		$dateStr:="2016/14/10"
End case 

$yearStr:=Substring:C12($dateStr; 1; 4)
$monthStr:=Substring:C12($dateStr; 6; 2)
$dayStr:=Substring:C12($dateStr; 9; 2)

$date:=makeDate(Num:C11($dayStr); Num:C11($monthStr); Num:C11($yearStr))


$0:=$date