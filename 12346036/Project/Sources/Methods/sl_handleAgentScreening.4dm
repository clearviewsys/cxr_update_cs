//%attributes = {}
/* Handles `[Agents]FullName` or `[Wires]BeneficiaryFullName` screening and return status
  This will not run any screening unless [Agents]AgentID is filled

#param $commandTypeParam 
       passes to `sl_handleScreening`
#param $optionsParam
       uses options from `sl_createDefaultOptionsObject
#param $formEventParam
       overrides `Form Event Code` in sl_handleScreening
#formEvents 
       see sl_handleScreening
#postcondition
       will enabled/disable 4D Widget with the name `b_check`
#author @Wai-Kin
*/
#DECLARE($commandTypeParam : Text; $optionsParam : Object; \
$formEventParam : Integer)->$match : Integer

//MARK:- Parameters Setup
var $commandType : Text
var $options : Object
var $formEvent : Integer
$options:=New object:C1471
$formEvent:=Form event code:C388
Case of 
	: (Count parameters:C259=1)
		$commandType:=$commandTypeParam
	: (Count parameters:C259=2)
		$commandType:=$commandTypeParam
		$options:=$optionsParam
	: (Count parameters:C259=3)
		$commandType:=$commandTypeParam
		$options:=$optionsParam
		$formEvent:=$formEventParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


var $checkName : Text
var $isCompany; $isNameFilled : Boolean
var $logIdPtr : Pointer

//MARK:- sl_handleScrenning setup 
utils_setUndefinedObjectValue($options; sl_AgentsFlag; "options"; "autoType")
$checkName:=[Agents:22]FullName:6
$isNameFilled:=[Agents:22]AgentID:1#""
$logIdPtr:=->[Agents:22]AgentID:1

//MARK:- Actual Screening

OBJECT SET ENABLED:C1123(*; "b_check"; [Agents:22]AgentID:1#"")

If ([Agents:22]AgentID:1#"")
	$match:=sl_handleScreening($commandType; $isCompany; $checkName; $options; $logIdPtr; $formEvent)
End if 
