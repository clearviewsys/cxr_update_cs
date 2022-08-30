//%attributes = {}
// goBackNHours ($numHours; $datePtr; $timePtr)
// Go back $numHours Back in time from a date and time
// i.e: goHoursBack (12;date("12/31/2017"); time("20:30:00")) will return: 12/31/2017 - 08:30:00
// i.e: goHoursBack (11;date("12/31/2017"); time("09:30:00")) will return: 12/30/2017 - 11:30:00

C_LONGINT:C283($1; $numHours)
C_POINTER:C301($2; $datePtr; $3; $timePtr)

C_TIME:C306($time; $oldTime)
C_REAL:C285($numDaysToGoback)

Case of 
	: (Count parameters:C259=3)
		
		$numHours:=$1
		$datePtr:=$2
		$timePtr:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TIME:C306($hoursToGoBack)
$hoursToGoBack:=Time:C179(String:C10($numHours)+":00:00")
If ($timePtr->=$hoursToGoBack)
	$timePtr->:=Time:C179(Time string:C180($timePtr->-$hoursToGoBack))
Else 
	$timePtr->:=Time:C179("24:00:00")-Time:C179(Time string:C180($hoursToGoBack-$timePtr->))
End if 

$numDaysToGoback:=-1*($numHours*(1/24))
$datePtr->:=Add to date:C393($datePtr->; 0; 0; $numDaysToGoback)







