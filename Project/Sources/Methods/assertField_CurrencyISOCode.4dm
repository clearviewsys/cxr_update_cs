//%attributes = {}
// assertField_CurrencyISOCode (->[table]; ->[field])


C_POINTER:C301($tablePtr; $fieldPtr; $1; $2)

C_POINTER:C301($oneTablePtr; $primaryKeyPtr)

$oneTablePtr:=->[Currencies:6]
$primaryKeyPtr:=->[Currencies:6]ISO4217:31

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=->[Registers:10]
		$fieldPtr:=->[Registers:10]Currency:19
		
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$fieldPtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

assertField_KnownKey($tablePtr; $fieldPtr; $oneTablePtr; $primaryKeyPtr)

