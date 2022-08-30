//%attributes = {}
/** Handle what text to search.

This could be written as
~~~
case of 
:(Form event code=On Data Change)
sl_handleSanctionListMatches
end case
~~~

#pre
     expected the the text box's variable is "Form.display.searchTerm"
#param $form
       the form object created through sl_setupDisplayListBox
#param $update
       force a reload?    
#param $resultObjectNameParam
       the name of list box
#formEvents On Data Change
#author @wai-kin
*/

var $form; $1 : Object
var $update; $2 : Boolean
var $resultObjectName; $3 : Text
$form:=Form:C1466
$update:=Form event code:C388=On Data Change:K2:15
$resultObjectName:=$form.resultObjectName
Case of 
	: (Count parameters:C259=0)
	: (Count parameters:C259=1)
		$form:=$1
	: (Count parameters:C259=2)
		$form:=$1
		$update:=$2
	: (Count parameters:C259=3)
		$form:=$1
		$update:=$2
		$resultObjectName:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($update)
	sl_handleSanctionListMatches($form; True:C214; $resultObjectName)
End if 
