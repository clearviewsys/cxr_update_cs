//%attributes = {}
// test_KeyValues
C_TEXT:C284($key; $value)

$key:="hello"
$value:="world"

setKeyValue($key; $value)
ASSERT:C1129(getKeyValue($key)=$value)

//keyValue_setValue ($key;$value)
//ASSERT(keyValue_getValue ($key)=$value)


$key:="hello"
$value:="ho"

setKeyValue($key; $value)
ASSERT:C1129(getKeyValue($key)=$value)
//
//keyValue_setValue ($key;$value)
//ASSERT(keyValue_getValue ($key)=$value)

$key:="hi"
$value:="ho"

setKeyValue($key; $value)
ASSERT:C1129(getKeyValue($key)=$value)
//
//keyValue_setValue ($key;$value)
//ASSERT(keyValue_getValue ($key)=$value)

ASSERT:C1129(""=getKeyValue("system"))
ASSERT:C1129(""=keyValue_getValue("system"))

