//%attributes = {}
/** Handle Goto page between CXRBlacklist and other server sources

#param $formEventParam
       Form event
#param $formParm
       Form object
#formEvents
       On Data Change
#author @wai-kin
*/
#DECLARE($formEventParam : Integer; $formParam : Object)
var $formEvent : Integer
var $form : Object
$formEvent:=Form event code:C388
$form:=Form:C1466
Case of 
	: (Count parameters:C259=0)
	: (Count parameters:C259=1)
		$formEvent:=$formEventParam
	: (Count parameters:C259=2)
		$formEvent:=$formEventParam
		$form:=$formParam
End case 
var $list : Text
$list:=utils_getValueFromObject($form; Form:C1466.sanctionLists.values[0]; \
"sanctionLists"; "currentValue")
Case of 
	: ($formEvent=On Data Change:K2:15)
		If ($list="CXRBlacklist")
			FORM GOTO PAGE:C247(1)
		Else 
			var $idx : Integer
			If (Form:C1466.useCXR)
				$idx:=$form.sanctionLists.index-1
			Else 
				$idx:=$form.sanctionLists.index
			End if 
			If (Form:C1466.kyc2020.length>$idx)
				FORM GOTO PAGE:C247(2)
				$form.kyc2020Result:=New object:C1471("kyc2020"; $form.kyc2020[$idx])
				//Form.kyc2020Result.kyc2020:=Form.kyc2020[$idx]
			End if 
		End if 
End case 