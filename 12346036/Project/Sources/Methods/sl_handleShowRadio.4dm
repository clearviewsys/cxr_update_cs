//%attributes = {}
/* Handle match type filter

#param $matches
       match type
#param $formParam
       the form object created through sl_setupDisplayListBox
#param $resultObjectNameParam
       the name of list box for each matched detail
#formEvents On Clicked
*/
#DECLARE($matchesParam : Text; $formParam : Object; $resultObjectNameParam : Text)
var $matches : Text
var $form : Object
var $resultObjectName : Text

$form:=Form:C1466
$resultObjectName:=$form.resultObjectName
Case of 
	: (Count parameters:C259=1)
		$matches:=$matchesParam
	: (Count parameters:C259=2)
		$matches:=$matchesParam
		$form:=$formParam
	: (Count parameters:C259=3)
		$matches:=$matchesParam
		$form:=$formParam
		$resultObjectName:=$resultObjectNameParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Form event code:C388=On Clicked:K2:4)
	$form.display.matches:=$matches
	sl_handleSanctionListMatches($form; True:C214; $resultObjectName)
End if 