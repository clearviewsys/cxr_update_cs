//%attributes = {}
/** Handle form event for sanction list viewing

#param $formParam
       Form Object
#param $searchObjectNameParam
       the name of the search object
#author @Wai-Kin
*/
#DECLARE($formParam : Object; $searchObjectNameParam : Text)

var $form : Object
var $searchObjectName : Text
Case of 
	: (Count parameters:C259=0)
		$form:=Form:C1466
		$searchObjectName:=$form.searchObjectName
	: (Count parameters:C259=1)
		$form:=$formParam
		$searchObjectName:=$form.searchObjectName
	: (Count parameters:C259=2)
		$form:=$formParam
		$searchObjectName:=$searchObjectNameParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($helpText)
$helpText:="Search fields names & match values"
C_BOOLEAN:C305($searchFields; $searchValues)
$searchFields:=$form.display.searchFields
$searchValues:=$form.display.searchValues
If ($searchFields)
	If (Not:C34($form.display.searchValues))
		$helpText:="Search field names"
	End if 
Else 
	If ($searchValues)
		$helpText:="Search match values"
	End if 
End if 
OBJECT SET PLACEHOLDER:C1295(*; $searchObjectName; $helpText)