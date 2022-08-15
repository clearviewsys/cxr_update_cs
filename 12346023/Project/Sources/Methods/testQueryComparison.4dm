//%attributes = {}
C_OBJECT:C1216($existingRecords)

$existingRecords:=ds:C1482.User_Log.query("UserName = "+"test")
$existingRecords:=ds:C1482.User_Log.query("UserName = "+"")
$existingRecords:=ds:C1482.User_Log.query("UserName = ")
//$existingRecords:=ds.User_Log.query("UserName = "+"")

