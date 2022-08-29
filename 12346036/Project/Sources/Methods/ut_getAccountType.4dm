//%attributes = {"shared":true}
// __UNIT_TEST
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("getAccountType"; Current method name:C684; "GET")
AJ_assert($test; getAccountType(1); "asset"; "1"; "return asset")
AJ_assert($test; getAccountType(0); ""; "0"; "return void")
//AJ_assert($test; getAccountType("A"); ""; "A"; "return void")
//AJ_assert($test; getAccountType(100); ""; "1"; "return void")

// 1 - Assets
// 2 - Liabilities
// 3 - Equities
// 4 - Revenues
// 5 - Expenses

C_OBJECT:C1216($accounts)
C_COLLECTION:C1488($accNames; $accCode)
C_LONGINT:C283($i)
$accounts:=New object:C1471
$accounts["1"]:="asset"
$accounts["2"]:="liability"
$accounts["3"]:="equity"
$accounts["4"]:="revenue"
$accounts["5"]:="expense"

$accNames:=OB Values:C1718($accounts)
$accCode:=OB Keys:C1719($accounts)
//C_COLLECTION($typeNumbers)
//$typeNumbers:=New collection({1:"asset"})

For ($i; 0; ($accCode.length)-1)
	AJ_assert($test; getAccountType(Num:C11($accCode[$i])); $accNames[$i]; $accCode[$i]; "return "+String:C10($accNames[$i]))
End for 