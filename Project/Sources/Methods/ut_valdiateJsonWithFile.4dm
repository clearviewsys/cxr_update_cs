//%attributes = {"shared":true}
// __UNIT_TEST

var $test : Object
$test:=AJ_UnitTest.new("Validate JSON With File"; Current method name:C684; "Validation")

var $expect : Object
$expect:=New object:C1471("success"; False:C215; "errors"; New collection:C1472)

$expect.errors:=New collection:C1472(New object:C1471(\
"message"; "The system cannot find the file specified.\r\n"\
))

$test.given:="Schema not found"
$test.should:="error object"
$test.expected:=$expect
$test.actual:=utils_validateJsonWithFile(New object:C1471(); "dafda.json")
$test.assert()

$expect.errors:=New collection:C1472(New object:C1471(\
"message"; "JSON malformed. Was expecting: \" }."\
))
$test.given:="Schema is malformed"
$test.should:="error object"
$test.expected:=$expect
$test.actual:=utils_validateJsonWithFile(New object:C1471(); "ut_malform.json")
$test.assert()

$expect.errors:=New collection:C1472(New object:C1471("message"; "JSON is a null object."))
$test.given:="No JSON"
$test.should:="error object"
$test.expected:=$expect
$test.actual:=utils_validateJsonWithFile(Null:C1517; "ut_schema.json")
$test.assert()

$expect.errors:=New collection:C1472(New object:C1471(\
"jsonPath"; "name"; \
"code"; 20; \
"message"; "Incorrect type. Expected type is: string"; \
"schemaPaths"; "properties.name.type"\
))
$test.given:="Invlid JSON"
$test.should:="error object"
$test.expected:=$expect
$test.actual:=utils_validateJsonWithFile(New object:C1471("name"; 123); "ut_schema.json")
$test.assert()


$expect.errors:=New collection:C1472()
$expect.success:=True:C214
$test.given:="Invalid JSON"
$test.should:="error object"
$test.expected:=$expect
$test.actual:=utils_validateJsonWithFile(New object:C1471("name"; "abc"); "ut_schema.json")
$test.assert()
