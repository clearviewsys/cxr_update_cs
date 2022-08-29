//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya 
//@21 July 2021

C_OBJECT:C1216($test; $item)
$test:=AJ_UnitTest.new("getTableName"; Current method name:C684; "GET")
AJ_assert($test; getTableName(1000); ""; "1000"; "")
//AJ_assert($test; getTableName("A"); ""; "A"; "")
//AJ_assert($test; getTableName("H1"); ""; "H1"; "")
//AJ_assert($test; getTableName("Hello"); ""; "Hello"; "")
AJ_assert($test; getTableName(-10); ""; "-10"; "")

AJ_assert($test; getTableName(); ""; "an empty string"; "")
AJ_assert($test; getTableName(0); "Default Privilege"; "0"; "return Default Privilege")



C_COLLECTION:C1488($tableCollection)

ARRAY TEXT:C222($tableNames; 0)
ARRAY LONGINT:C221($tableNums; 0)

Begin SQL
	
	SELECT TABLE_NAME, TABLE_ID
	FROM _USER_TABLES
	INTO :$tableNames, :$tableNums;
End SQL

$tableCollection:=New collection:C1472

ARRAY TO COLLECTION:C1563($tableCollection; $tableNames; "tableName"; $tableNums; "tableNumber")

For each ($item; $tableCollection)
	
	AJ_assert($test; getTableName($item.tableNumber); $item.tableName; String:C10($item.tableNumber); "return "+$item.tableName)
End for each 