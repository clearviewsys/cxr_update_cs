//%attributes = {}
// handleFillMonthlyCalendarArrays (month; year)
C_LONGINT:C283($1; $2; $month; $year)
$month:=$1
$year:=$2

ARRAY TEXT:C222(arrWD1; 6)
ARRAY TEXT:C222(arrWD2; 6)
ARRAY TEXT:C222(arrWD3; 6)
ARRAY TEXT:C222(arrWD4; 6)
ARRAY TEXT:C222(arrWD5; 6)
ARRAY TEXT:C222(arrWD6; 6)
ARRAY TEXT:C222(arrWD7; 6)
C_LONGINT:C283($row; $col; $day)
C_POINTER:C301($arrPtr)


For ($col; 1; 7)  // weekdays
	$arrPtr:=Get pointer:C304("arrWD"+String:C10($col))
	
	For ($row; 1; 6)  // weeks (1 to 6 row)
		$day:=cal_getMonthlyCalendarDayRC($row; $col; $month; $year)
		If ($day>0)
			$arrPtr->{$row}:=String:C10($day)
		Else 
			$arrPtr->{$row}:=""
		End if 
	End for 
	
End for 