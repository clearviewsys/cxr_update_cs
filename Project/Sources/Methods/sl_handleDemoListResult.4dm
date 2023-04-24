//%attributes = {}
/** Add a list name into Form.peps or Form.sanctions lists. 

#usage SanctionListCheckDemo Form in $options.pointers.handleDetailMethod
#param $resultParam
       Object from `ds.SanctionCheckLog.toObject()`
#param $sanctionListParam
       Object from `ds.SanctionLists.toObject()`
#param $option
       list of option, see sl_createDefaultOptionsObject for default values and keys
#authro @wai-kin
*/
#DECLARE($resultParam : Object; $sanctionListParam : Object; $optionsParam : Object)

var $result : Object
var $sanctionList : Object
var $options : Object

Case of 
	: (Count parameters:C259=3)
		$result:=$resultParam
		$sanctionList:=$sanctionListParam
		$options:=$optionsParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($result.CheckResult#0)
	If ($sanctionList.isPEP)
		Form:C1466.peps:=Form:C1466.peps+$sanctionList.ShortName+"\n"
	Else 
		Form:C1466.sanctions:=Form:C1466.sanctions+$sanctionList.ShortName+"\n"
	End if 
End if 
Form:C1466.ran:=Form:C1466.ran+$sanctionList.ShortName+"\n"
var $entity : cs:C1710.SanctionCheckLogEntity
$entity:=ds:C1482.SanctionCheckLog.new()
$entity.fromObject($result)
Form:C1466.results.push($entity)