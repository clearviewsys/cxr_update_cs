//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya
//@09 Mar 2021
// Not complteted yet
C_OBJECT:C1216($test)
C_TEXT:C284($giveninfo)
$test:=AJ_UnitTest.new("FJ_QueryRegisters_CTR"; Current method name:C684; "No Category")
$giveninfo:="customer has two cash transcations 2800+300 "
AJ_assert($test; FJ_QueryRegisters_CTR("CUS2065728"; !2021-03-09!; !2021-03-09!); 3100; $giveninfo; "return 3100")
