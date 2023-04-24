//%attributes = {}
C_TEXT:C284($querySting; $databaseName)
C_OBJECT:C1216($result; $abc)
C_COLLECTION:C1488($coll)

$querySting:="SELECT * FROM \"Questions\" LIMIT 10;"
$databaseName:="vd-clearviewsys/test-db"
$abc:=queryBitIO($querySting; $databaseName)
$result:=JSON Parse:C1218($abc.response)
$coll:=$result.data
