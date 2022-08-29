//%attributes = {}
/* Picked the worst status outcome. The order is -1, 2, 1, 0

#param $currentParam
       the current result status
#param $latestStatusParam
       the new status
#return 
       the result
#author @wai-kin
*/
#DECLARE($currentParam : Real; $latestStatusParam : Real)->$outcome : Real

var $current; $latestStatus : Real

Case of 
	: (Count parameters:C259=2)
		$current:=$currentParam
		$latestStatus:=$latestStatusParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: (($current=-1) | ($latestStatus=-1))
		$outcome:=-1
	: (($current=2) | ($latestStatus=2))
		$outcome:=2
	: (($current=1) | ($latestStatus=1))
		$outcome:=1
	Else 
		$outcome:=0
End case 