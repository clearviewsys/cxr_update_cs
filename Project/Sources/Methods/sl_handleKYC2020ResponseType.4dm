//%attributes = {}
/** handle KYC2020 response type setting

#param $formEventParam
       Form event
#param $objectNameParam
       Form widget name
#param $responseTypeParam
       the response type to set
#formEvent On Data Change
#author @wai-kin
*/
#DECLARE($formEventParam : Integer; $objectNameParam : Text; \
$responseTypeParam : Text)

var $formEvent : Integer
var $objectName : Text
var $responseType : Text

$formEvent:=Form event code:C388
$objectName:="combo_K2020ResponseType"
$responseType:=Form:C1466.responseType

Case of 
	: (Count parameters:C259=1)
		$formEvent:=$formEventParam
	: (Count parameters:C259=2)
		$formEvent:=$formEventParam
		$objectName:=$objectNameParam
	: (Count parameters:C259=3)
		$formEvent:=$formEventParam
		$objectName:=$objectNameParam
		$responseType:=$responseTypeParam
End case 

Case of 
	: ($formEvent=On Data Change:K2:15)
		ARRAY TEXT:C222($outputArr; 0)
		C_LONGINT:C283($types)
		$types:=Load list:C383("KYC2020ResponseType")
		[SanctionLists:113]Details:13.KYC2020.responseType:=Find in list:C952($types; $responseType; 1)
		
End case 
