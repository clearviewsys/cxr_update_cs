//%attributes = {}
// __UNIT_TEST
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("ForgotPasswordValid"; Current method name:C684; "Validation")



C_BOOLEAN:C305($first; $second; $third; $fourth; $fifth)

//False
$first:=forgotPasswordCodeValid(""; Time:C179("00:00:00"); Date:C102("09/30/19"))
//True
$second:=forgotPasswordCodeValid("123456"; Time:C179("23:59:00"); Date:C102("09/30/19"))
//False
$third:=forgotPasswordCodeValid("123456"; Time:C179("12:00:00"); Date:C102("09/30/19"))
//False
$fourth:=forgotPasswordCodeValid("123456"; Time:C179("00:00:00"); Date:C102("10/05/19"))
//True from 11:45pm to midnight, false otherwise
$fifth:=forgotPasswordCodeValid("123456"; Time:C179("00:01:00"); Date:C102("10/01/19"))

