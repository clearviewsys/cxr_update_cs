//%attributes = {}
//setTimerInMinutes(minutes)
// this activates the timer in minutes

C_LONGINT:C283($min; $1)
$min:=$1*60*60

SET TIMER:C645($min)