//%attributes = {}
/* Handle match value or field name

#param $searchType
       search by field or by value?
#param $form
       the form object created through sl_setupDisplayListBox
#param $update
       force an update?
#param $resultObjectNameParam
       the name of list box for each matched detail
#formEvents On Clicked
#author @wai-kin
*/
#DECLARE($searchTypeParam : Text; $formParam : Object; \
$updateParam : Boolean; $resultObjectNameParam : Text)
var $searchType : Text
var $form : Object
var $update : Boolean
var $resultObjectName : Text
$form:=Form:C1466
$update:=Form event code:C388=On Clicked:K2:4
$resultObjectName:=$form.resultObjectName
Case of 
	: (Count parameters:C259=1)
		$searchType:=$searchTypeParam
	: (Count parameters:C259=2)
		$searchType:=$searchTypeParam
		$form:=$formParam
	: (Count parameters:C259=3)
		$searchType:=$searchTypeParam
		$form:=$formParam
		$update:=$updateParam
	: (Count parameters:C259=4)
		$searchType:=$searchTypeParam
		$form:=$formParam
		$update:=$updateParam
		$resultObjectName:=$resultObjectNameParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($update)
	$form.display[$searchType]:=$form[$searchType]=1
	sl_handleSanctionListMatches($form; True:C214; $resultObjectName)
End if 