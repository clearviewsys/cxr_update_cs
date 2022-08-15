//%attributes = {}


// test_sample ( string)


C_TEXT:C284($1; $str)

Case of 
	: (Count parameters:C259=0)
		$str:="test"
	: (Count parameters:C259=1)
		$str:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

myAlert($str)

C_OBJECT:C1216($obj)

$obj:=ds:C1482.Customers.query("FirstName = 'T'")

If ($obj#Null:C1517)
	$obj:=$obj.first()
Else 
	ALERT:C41("Result is Null")
End if 