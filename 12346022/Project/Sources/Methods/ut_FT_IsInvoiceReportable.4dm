//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya
//@ 15 Mar 2021

C_OBJECT:C1216($test)
C_BOOLEAN:C305($result)
$test:=AJ_UnitTest.new("FT_IsInvoiceReportable"; Current method name:C684; "No Category")

AJ_assert($test; FT_IsInvoiceReportable("INV140201"; !2021-03-15!; True:C214); True:C214; "an invoice info over ?"; "return True")
AJ_assert($test; FT_IsInvoiceReportable("INV140200"; !2021-03-09!; True:C214); False:C215; "an invoice info less than ?"; "return False")
$result:=FT_IsInvoiceReportable("INV140201"; !2021-03-15!; False:C215)
AJ_assert($test; $result; True:C214; "an invoice info over ?"; "return True")
$result:=FT_IsInvoiceReportable("INV140189"; !2021-01-30!; True:C214)
AJ_assert($test; $result; False:C215; "an invoice info less than ?"; "return False")
AJ_assert($test; FT_IsInvoiceReportable("INV140189"; !2021-01-30!; False:C215); False:C215; "an invoice info less than ?"; "return False")
