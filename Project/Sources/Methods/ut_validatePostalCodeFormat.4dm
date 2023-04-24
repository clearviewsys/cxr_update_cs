//%attributes = {"shared":true}
// __UNIT_TEST
// written by @viktor
// Jan 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("validatePostalCodeFormat"; Current method name:C684; "UTIL.validate")
// validatePostalCodeFormat

C_TEXT:C284($should; $given)
C_TEXT:C284($postalCode; $countryCode)
C_BOOLEAN:C305($isValid; $expectedValidity)


// CANADA
$postalCode:="V1V1V1"
$countryCode:="CA"
$expectedValidity:=True:C214
$given:="a valid postal code with no space"
$should:="return True"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)

$postalCode:="V1V 1V1"
$countryCode:="CA"
$expectedValidity:=True:C214
$given:="a valid postal code with space"
$should:="return True"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)

$postalCode:="v1V1v1"
$countryCode:="CA"
$expectedValidity:=True:C214
$given:="a valid postal code with no space and lower case letters"
$should:="return True"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)

$postalCode:="v1V-1v1"
$countryCode:="CA"
$expectedValidity:=True:C214
$given:="a valid postal code with '-' in between"
$should:="return True"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)

$postalCode:="V1V1VV"
$countryCode:="CA"
$expectedValidity:=False:C215
$given:="an invalid postal code"
$should:="return False"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)

$postalCode:="V1V1V1v"
$countryCode:="CA"
$expectedValidity:=False:C215
$given:="an invalid postal code with too many characters"
$should:="return False"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)

// UNITED STATES
$postalCode:="90210"
$countryCode:="US"
$expectedValidity:=True:C214
$given:="a valid postal code"
$should:="return True"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)

$postalCode:="90210-1234"
$countryCode:="US"
$expectedValidity:=True:C214
$given:="a valid postal code with hyphen"
$should:="return True"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)

$postalCode:="9021d"
$countryCode:="US"
$expectedValidity:=False:C215
$given:="an invalid postal code with letter"
$should:="return False"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)

$postalCode:="9021"
$countryCode:="US"
$expectedValidity:=False:C215
$given:="an invalid postal code too short"
$should:="return False"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)

$postalCode:="902100"
$countryCode:="US"
$expectedValidity:=False:C215
$given:="an invalid postal code too long"
$should:="return False"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)


// NEW ZEALAND
$postalCode:="9021"
$countryCode:="NZ"
$expectedValidity:=True:C214
$given:="a valid postal code"
$should:="return True"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)

$postalCode:="90210"
$countryCode:="NZ"
$expectedValidity:=False:C215
$given:="a valid postal code too long"
$should:="return False"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)

$postalCode:="902"
$countryCode:="NZ"
$expectedValidity:=False:C215
$given:="a valid postal code too short"
$should:="return False"
$isValid:=validatePostalCodeFormat($postalCode; $countryCode)
AJ_assert($test; $isValid; $expectedValidity; $given; $should)