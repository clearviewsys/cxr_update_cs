//%attributes = {}
C_TEXT:C284($1; $2; $3; $key; $value; $defaultValue; $0)
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

Case of 
	: ((OB Is defined:C1231(Storage:C1525; "keyValues")) & (OB Is defined:C1231(Storage:C1525.keyValues; $key)))
		Use (Storage:C1525)
			$value:=Storage:C1525.keyValues[$key]
			
			If ($value="") & ($defaultValue#"")  //5/8/21 ibb
				$value:=$defaultValue
			End if 
			
		End use 
	Else 
		$value:=getKeyValue_old($key; $defaultValue)  //fallback until initCachedKeyValue is added to server startup, then replace with $value:=$defaultValue
End case 

$0:=$value
