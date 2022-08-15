//%attributes = {}
// query Customers #ORDA

C_OBJECT:C1216($es; $entity; $es1)

$es:=ds:C1482.Customers.query("FullName='Tiran@'")
$es1:=$es[0]
If ($es.length>0)
	$entity:=$es.first().employer.employees.minus($es1)  // all colleagues of Tiran
End if 
//[Customers]FullName
