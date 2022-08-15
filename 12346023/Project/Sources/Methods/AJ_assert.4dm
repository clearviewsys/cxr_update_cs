//%attributes = {}
// AJ_Assert ( testObject; actualValue: variant ; expectedValue: variant; given: text ; should: text ) : void
// helper function to call the AJ Unit test
// before calling this method you need to call $test:=AJ_UnitTest.new(method to test;Current method name;"Grouping")

C_OBJECT:C1216($test; $1)
C_VARIANT:C1683($2; $3; $expected; $actual)
C_TEXT:C284($given; $4)
C_TEXT:C284($should; $5)

Case of 
	: (Count parameters:C259=5)
		$test:=$1
		$actual:=$2
		$expected:=$3
		$given:=$4
		$should:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$test.expected:=$expected
$test.actual:=$actual
$test.given:=$given
$test.should:=$should
$test.assert()
