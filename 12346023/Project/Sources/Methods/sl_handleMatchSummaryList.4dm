//%attributes = {}
/* Handle List name filter

#param $formParam
       the form object created through sl_setupDisplayListBox
#param $reloadParam
       force a reload?
#param $resultObjectNameParam
       the name of list box for each matched detail
#formEvents On Selection Change
#author @wai-kin
*/
#DECLARE($formParam : Object; $changesParam : Boolean; $resultObjectNameParam : Text)

var $form : Object
var $changes : Boolean
var $resultObjectName : Text
$form:=Form:C1466
$changes:=Form event code:C388=On Selection Change:K2:29
$resultObjectName:=$form.resultObjectName
Case of 
	: (Count parameters:C259=0)
	: (Count parameters:C259=1)
		$form:=$formParam
	: (Count parameters:C259=2)
		$form:=$formParam
		$changes:=$changesParam
	: (Count parameters:C259=3)
		$form:=$formParam
		$changes:=$changesParam
		$resultObjectName:=$resultObjectNameParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($changes)
	Form:C1466.display.lists:=New collection:C1472
	
	C_OBJECT:C1216($list)
	For each ($list; Form:C1466.selectedLists)
		Form:C1466.display.lists.push($list.name)
	End for each 
	sl_handleSanctionListMatches($form; True:C214; $resultObjectName)
End if 
