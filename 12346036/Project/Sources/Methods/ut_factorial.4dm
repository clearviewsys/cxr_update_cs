//%attributes = {"shared":true}
// __UNIT_TEST
// written by @nora
//Jan 2021

// test method for factorial

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("factorial"; Current method name:C684; "Math")

// Order of parameters: test, actual, exp, given, should
AJ_assert($test; factorial(3); 6; "Given the value 3"; "should result in the value 6")
AJ_assert($test; factorial(4); 24; "Given the value 4"; "should result in the value 24")
AJ_assert($test; factorial(-1); 1; "Given the value -1"; "should result in the value 1")
AJ_assert($test; factorial(0); 1; "Given the value 0"; "should result in the value 1")
AJ_assert($test; factorial(10); 3628800; "Given the value 10"; "should result in the value 3628800")




//$test.given:="Given the value 3"
//$test.should:="result in the value 6"
//$test.expected:=6
//$test.actual:=factorial(3)
//$test.assert()

//$test.given:="Given the value 4"
//$test.should:="result in the value 24"
//$test.expected:=24
//$test.actual:=factorial(4)
//$test.assert()

//$test.given:="Given the value -1"
//$test.should:="result in the value 1"
//$test.expected:=1
//$test.actual:=factorial(-1)
//$test.assert()

//$test.given:="Given the value 0"
//$test.should:="result in the value 1"
//$test.expected:=1
//$test.actual:=factorial(0)
//$test.assert()

//$test.given:="Given the value 10"
//$test.should:="result in the value 3628800"
//$test.expected:=3628800
//$test.actual:=factorial(10)
//$test.assert()


//------- OLD WAY -----------------------

//C_LONGINT($n)

//ASSERT(factorial(3)=6)  // pass
//ASSERT(factorial(4)=24)  // pass
//ASSERT(factorial(-1)=1)  // pass
//ASSERT(factorial(0)=1)  // pass
//ASSERT(factorial(10)=(10*9*8*7*6*5*4*3*2))


