//%attributes = {}
C_OBJECT:C1216($keyValuesObject; $keyValuesEntities; $entity)

$keyValuesEntities:=ds:C1482.KeyValues.all()
$keyValuesObject:=New shared object:C1526
Use ($keyValuesObject)
	For each ($entity; $keyValuesEntities)
		$keyValuesObject[$entity.Key]:=$entity.Value
	End for each 
End use 

Use (Storage:C1525)
	Storage:C1525.keyValues:=$keyValuesObject
End use 