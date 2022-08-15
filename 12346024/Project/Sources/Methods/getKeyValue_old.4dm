//%attributes = {"shared":true}
// getKeyValue (key; default): textValue
// returns the value stored in the keyValues table for primarykey 'Key'
// make sure to update getKeyValueDescription

C_TEXT:C284($1; $2; $key; $value; $defaultValue; $0)
Case of 
	: (Count parameters:C259=0)
		$key:="key1"
		$defaultValue:="value1"
		
	: (Count parameters:C259=1)
		$key:=$1
		$defaultValue:=""
	: (Count parameters:C259=2)
		$key:=$1
		$defaultValue:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([KeyValues:115])
QUERY:C277([KeyValues:115]; [KeyValues:115]Key:2=$key)
If (Records in selection:C76([KeyValues:115])=1)
	$value:=[KeyValues:115]Value:3
Else 
	$value:=$defaultValue
End if 

$0:=$value