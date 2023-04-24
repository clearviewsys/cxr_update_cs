//%attributes = {}
// sl_searchTodayScreening($searchName : Text; $method : Text; $others : Object\
)->$history : cs.SanctionCheckLogEntity
// Author Wai-Kin

var $1; $searchName : Text
var $2; $method : Text
var $3; $others : Object
var $0; $history : cs:C1710.SanctionCheckLogEntity
var $found : cs:C1710.SanctionCheckLogEntity

Case of 
	: (Count parameters:C259=2)
		$searchName:=$1
		$method:=$2
		$others:=New object:C1471
	: (Count parameters:C259=3)
		$searchName:=$1
		$method:=$2
		$others:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: ($method="v2")
		$history:=ds:C1482.SanctionCheckLog.query(\
			"FullName = ':1' & CheckDate = :2 & CheckResult # -1 & SanctionList = :3&"+\
			"isEntity = :4"; $searchName; Current date:C33(*); $others.shortName; \
			$others.isEntity)
	: ($method="KYC2020")
		$history:=ds:C1482.SanctionCheckLog.query(\
			"FullName = ':1' & CheckDate = :2 & CheckResult # -1 & SanctionList = 'KYC2020' &"+\
			"isEntity = :3"; $searchName; Current date:C33(*); $others.isEntity)
	Else 
		ASSERT:C1129(False:C215; "Unknown method: "+$method)
End case 

If ($history.length#0)
	var $minus : cs:C1710.SanctionCheckLogSelection
	$minus:=ds:C1482.SanctionCheckLog.newSelection()
	For each ($found; $history)
		If (sl_getSanctionSourceForRecord($found)#$method)
			$minus:=$minus.add($found)
		End if 
	End for each 
End if 
$history:=$history.minus($minus)
$0:=$history