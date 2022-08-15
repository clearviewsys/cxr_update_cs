//%attributes = {}
// FJ_FormatTime ({$reftime})
// Format time for FIJI Reports using hhmm format

C_TIME:C306($1; $refTime)
C_TEXT:C284($0; $timeStr)

Case of 
	: (Count parameters:C259=0)
		$refTime:=Current time:C178(*)
		
	: (Count parameters:C259=1)
		$refTime:=$1
		
End case 
If ($refTime#?00:00:00?)
	
	$timeStr:=String:C10($refTime)
	$timeStr:=Substring:C12($timeStr; 1; 2)+Substring:C12($timeStr; 4; 2)
Else 
	$timeStr:=""
End if 


$0:=$timeStr
