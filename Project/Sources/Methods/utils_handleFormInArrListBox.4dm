//%attributes = {}
/** Display a collection in a array listbox
#author Wai-Kin
*/
#DECLARE($useCollectionParam : Collection; $arrListBoxColumnNameParam : Text)

var $useCollection : Collection
var $arrListBoxColumnName : Text
Case of 
	: (Count parameters:C259=2)
		$useCollection:=$useCollectionParam
		$arrListBoxColumnName:=$arrListBoxColumnNameParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

COLLECTION TO ARRAY:C1562($useCollection; \
OBJECT Get pointer:C1124(Object named:K67:5; $arrListBoxColumnName)->)