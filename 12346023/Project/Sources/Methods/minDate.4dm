//%attributes = {}
// minDate (date1;date2) : sooner of the two dates
C_DATE:C307($date1; $date2; $1; $2; $0)
$date1:=$1
$date2:=$2

Case of 
	: (($date1=!00-00-00!) & ($date2=!00-00-00!))
		$0:=!00-00-00!
		
	: (($date1=!00-00-00!) & ($date2#!00-00-00!))
		$0:=$date2
		
	: (($date1#!00-00-00!) & ($date2=!00-00-00!))
		$0:=$date1
		
	: (($date1#!00-00-00!) & ($date2#!00-00-00!))
		If ($date1<$date2)
			$0:=$date1
		Else 
			$0:=$date2
		End if 
End case 
