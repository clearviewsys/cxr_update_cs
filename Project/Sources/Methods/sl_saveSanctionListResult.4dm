//%attributes = {}
/** Saves a [SanctionCheckLog] record as needed. Setup so that it can be use
for cs.SanctionScreeningOptions field "handleScreenResult"

#param $resultParm
       [SanctionCheckLog] as an object
#param $sanctionListParam
       [SanctionLists] as an object
#param $option
       list of option, see sl_createDefaultOptionsObject 
#author @wai-kin
*/
#DECLARE($resultParam : Object; $sanctionListParam : Object; $optionsParam : Object)->$saved : Boolean
var $result : Object
var $sanctionList : Object
var $options : Object
var $query : Text

Case of 
	: (Count parameters:C259=1)
		$result:=$resultParam
		$sanctionList:=Null:C1517
		$options:=Null:C1517
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
	//$matched:=ds.SanctionCheckLog.query($query; New object("parameters"; $result))
	$matched:=ds:C1482.SanctionCheckLog.query("FullName = :1 "+\
		"AND isEntity= :2 "+\
		"AND CheckDate=:3 "+\
		"AND CheckResult # :4 "+\
		"AND UseServer = :5 "+\
		"AND SanctionList = :6 "+\
		"AND internalTableID = :7 "+\
		"AND InternalRecordID = :8"; \
		$result.FullName; $result.isEntity; \
		$result.CheckDate; -1; \
		$result.UseServer; $result.SanctionList; \
		$result.internalTableID; $result.InternalRecordID)
	If ($matched#Null:C1517)
		$willSave:=$matched.length=0
	Else 
		$willSave:=True:C214
	End if 
End if 


//MARK:- Saves the record
If ($willSave)
	var $entity : cs:C1710.SanctionCheckLogEntity
	If (OB Instance of:C1731($result; cs:C1710.SanctionCheckLogEntity))
		$entity:=$result
	Else 
		$entity:=ds:C1482.SanctionCheckLog.new().fromObject($result)
	End if 
	$entity.save()
	return True:C214
Else 
	return False:C215
End if 