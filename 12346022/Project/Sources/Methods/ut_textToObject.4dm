//%attributes = {"shared":true}
// __UNIT_TEST
// Author: Wai-Kin
// JAn 2021

C_OBJECT:C1216($test)
C_TEXT:C284($fieldSplit; $lineSplit; $input)
C_TEXT:C284($should; $input)
$test:=AJ_UnitTest.new("splitTextToObject"; Current method name:C684; "utils")

$fieldSplit:=":"
$lineSplit:=";"

$input:=""
AJ_assert($test; splitTextToObject($input; $fieldSplit; $lineSplit); New object:C1471(); \
"Empty String"; "Empty object")

$should:="Filled object"
$input:="Hello:"
AJ_assert($test; splitTextToObject($input; $fieldSplit; $lineSplit); \
New object:C1471("Hello"; ""); \
$input; $should)

$should:="Filled object"
$input:="Hello:;"
AJ_assert($test; splitTextToObject($input; $fieldSplit; $lineSplit); \
New object:C1471("Hello"; ""); \
$input; $should)

$input:="first:John;last:Smith"
AJ_assert($test; splitTextToObject($input; $fieldSplit; $lineSplit); \
New object:C1471("first"; "John"; "last"; "Smith"); \
$input; $should)

$input:="first:John;last:Smith;birthday:June 24, 1952"
AJ_assert($test; splitTextToObject($input; $fieldSplit; $lineSplit); \
New object:C1471("first"; "John"; "last"; "Smith"; \
"birthday"; "June 24, 1952"); \
$input; $should)