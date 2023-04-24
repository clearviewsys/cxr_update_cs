//%attributes = {}
C_TEXT:C284($key; $1; $value; $2)

Case of 
	: (Count parameters:C259=2)
		$key:=$1
		$value:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Use (Storage:C1525)
	Use (Storage:C1525.keyValues)
		Storage:C1525.keyValues[$key]:=$value
	End use 
End use 

If (Application type:C494=4D Remote mode:K5:5)
	setCachedKeyValuesServer
End if 