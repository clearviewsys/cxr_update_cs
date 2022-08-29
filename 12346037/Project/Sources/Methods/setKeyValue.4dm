//%attributes = {"shared":true}
// setKeyValue (key; Value)
// first it looks for 'key' in the table KeyValues
// if the record exist, we replace the value
// otherwise we create value
// -- if you only pass in the KEY then this checks to make sure it exists ONLY--
// PRE: Key#""

C_TEXT:C284($key; $1; $value; $2; $0)
C_LONGINT:C283($found)
Case of 
	: (Count parameters:C259=0)
		$key:="key2"
		$value:="value"+String:C10(Current time:C178)
		
	: (Count parameters:C259=1)  //just the key - make sure the keyvalue exists even if blank value
		$key:=$1
		$value:=""
		
	: (Count parameters:C259=2)
		$key:=$1
		$value:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ASSERT:C1129($key#""; "Key cannot be null")

SET QUERY DESTINATION:C396(Into current selection:K19:1)
QUERY:C277([KeyValues:115]; [KeyValues:115]Key:2=$key)
$found:=Records in selection:C76([KeyValues:115])
READ WRITE:C146([KeyValues:115])

If ($found=1)  // found
	LOAD RECORD:C52([KeyValues:115])
Else   // assert nothing found
	ASSERT:C1129($found=0)  // if this fails, it means there were more than one record in the keyValue pair
	CREATE RECORD:C68([KeyValues:115])
	[KeyValues:115]Key:2:=$key
End if 

If (Count parameters:C259=1)  //just make sure this key exists
Else 
	[KeyValues:115]Value:3:=$value
	setCachedKeyValue($key; $value)
End if 

SAVE RECORD:C53([KeyValues:115])
UNLOAD RECORD:C212([KeyValues:115])
READ ONLY:C145([KeyValues:115])
$0:=$value
