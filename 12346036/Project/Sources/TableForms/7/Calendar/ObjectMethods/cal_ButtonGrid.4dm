//C_LONGINT(vRow;vColumn)

//getButtonGridClickRC (Self;7;->vRow;->vColumn)

C_LONGINT:C283($offset; $day; $clickedSerial; $max)

$offset:=cal_getFirstWeekDayNumberOf(cal_vMonth; cal_vYear)
$max:=cal_getNumberOfDaysInMonth(cal_vMonth; cal_vYear)+$offset-1
$clickedSerial:=Self:C308->
If (($clickedSerial<$offset) | ($clickedSerial>$max))
	$day:=0
Else 
	$day:=$clickedSerial-$offset+1
End if 

If ($day>0)
	cal_gotoDay($day)
End if 