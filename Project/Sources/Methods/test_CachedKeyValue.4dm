//%attributes = {}


C_TEXT:C284($key; $value; $default)
$default:="undefined"

//test getter

$value:=getKeyValue("auth.designerTries"; $default)
ASSERT:C1129($value#$default)

$value:=getKeyValue("random_key_that_doesnot_exist"; $default)
ASSERT:C1129($value=$default)

//test setter
//test new key
$key:="some.random.key."+String:C10(Random:C100%101)
setKeyValue($key; "myValue")
$value:=getKeyValue($key; $default)
ASSERT:C1129($value="myValue")
//test existing key
setKeyValue($key; "myNewValue")
$value:=getKeyValue($key; $default)
ASSERT:C1129($value="myNewValue")

//cleanup
C_OBJECT:C1216($keyValueToDelete; $notDropped)
$keyValueToDelete:=ds:C1482.KeyValues.query("Key = :1"; $key)
If ($keyValueToDelete.length=1)
	$notDropped:=$keyValueToDelete.drop(dk stop dropping on first error:K85:26)
	If ($notDropped.length#0)
		myAlert("Unable to delete test key "+$key+" from key values. Please delete it manually.")
	End if 
End if 
