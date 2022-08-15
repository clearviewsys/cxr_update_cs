//%attributes = {}
/** Saves a [SanctionCheckLog] record as needed
#param $resultParm
       [SanctionCheckLog] as an object
#param $sanctionListParam
       [SanctionLists] as an object
#param $option
       list of option, see sl_createDefaultOptionsObject 
#author @wai-kin
*/
#DECLARE($resultParam : Object; $sanctionListParam : Object; $optionsParam : Object)

var $result : Object
var $sanctionList : Object
var $options : Object
var $query : Text

Case of 
	: (Count parameters:C259=3)
		$result:=$resultParam
		$sanctionList:=$sanctionListParam
		$options:=$optionsParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $willSave : Boolean
//MARK:- Check for associated record
$willSave:=$result.InternalRecordID#""

//MARK:- Check if the same good test ran today
If ($willSave)
	$query:="FullName = :FullName & isEntity = :isEntity &"+\
		"CheckDate = :CheckDate & CheckResult # -1 &"+\
		"UseServer = :UseServer & SanctionList = :SanctionList & "+\
		"internalTableID = :internalTableID & InternalRecordID = :InternalRecordID"
	
	var $matched : 4D:C1709.EntitySelection
	$matched:=ds:C1482.SanctionCheckLog.query($query; New object:C1471("parameters"; $result))
	$willSave:=$matched.length=0
End if 


//MARK:- Saves the record
If ($willSave)
	var $entity : cs:C1710.SanctionCheckLogEntity
	$entity:=ds:C1482.SanctionCheckLog.new().fromObject($result)
	$entity.save()
End if 