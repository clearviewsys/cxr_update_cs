//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya
//@ 15 Mar 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("isCustomerReportable"; Current method name:C684; "No Category")
createDummyCustomers()
AJ_assert($test; isCustomerReportable(""); True:C214; "an empty Customer ID"; "return an False")
AJ_assert($test; isCustomerReportable("_self"); False:C215; "a _self customer ID is passed in"; "return an False")
AJ_assert($test; isCustomerReportable("_self_"); False:C215; "a _self_ customer ID is passed in"; "return an False")
AJ_assert($test; isCustomerReportable("Self-QS"); False:C215; "a Self-QS customer ID is passed in"; "return an False")
AJ_assert($test; isCustomerReportable("Self-TT"); False:C215; "a Self-TT customer ID is passed in"; "return an False")
AJ_assert($test; isCustomerReportable("Self"); False:C215; "a Self customer ID is passed in"; "return an False")
AJ_assert($test; isCustomerReportable("Self-1"); False:C215; "a Self-1 customer ID is passed in"; "return an False")

AJ_assert($test; isCustomerReportable("_WALKIN"); False:C215; "a Walk-in customer ID is passed in"; "return an False")
AJ_assert($test; isCustomerReportable("_WALKIN_"); False:C215; "a Walk-in customer ID is passed in"; "return an False")
AJ_assert($test; isCustomerReportable("000-TT"); False:C215; "a Walk-in customer ID is passed in"; "return an False")
AJ_assert($test; isCustomerReportable("000"); False:C215; "a Walk-in customer ID is passed in"; "return an False")


AJ_assert($test; isCustomerReportable("_NORMAL_"); True:C214; "a normal customer ID is passed in"; "return an True")
AJ_assert($test; isCustomerReportable("_WListEXPToday"); True:C214; "a normal customer ID is passed in"; "return an True")


