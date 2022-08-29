//%attributes = {}
// returns difference between two dates and times in seconds

C_LONGINT:C283($0; $firstTimeStamp; $secondTimeStamp)
C_DATE:C307($1; $firstDate; $3; $secondDate)
C_TIME:C306($2; $firstTime; $4; $secondTime)

$0:=0
$firstDate:=!00-00-00!
$secondDate:=!00-00-00!
$firstTime:=0
$secondTime:=0

If (Count parameters:C259>0)
	$firstDate:=$1
	If (Count parameters:C259>1)
		$firstTime:=$2
		$secondDate:=Current date:C33
		$secondTime:=Current time:C178
		If (Count parameters:C259>2)
			$secondDate:=$3
			If (Count parameters:C259>3)
				$secondTime:=$4
			End if 
		End if 
	End if 
End if 

$firstTimeStamp:=UTIL_TS_getTimeStampFromDate($firstDate; $firstTime)
$secondTimeStamp:=UTIL_TS_getTimeStampFromDate($secondDate; $secondTime)

$0:=$secondTimeStamp-$firstTimeStamp
