//%attributes = {"shared":true}
// __UNIT_TEST
// written by @viktor
// Jan 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("validateIBAN_UsingXML"; Current method name:C684; "API.validateIBAN")

C_TEXT:C284($IBAN; $errCode; $bankName; $countryCode; $city; $address; $BIC; $validCheckSum)
C_TEXT:C284($expected; $should; $given)


// PROVIDING A CORRENT IBAN - FRANCE
$IBAN:="FR7630006000011234567890189"
$given:="Provinding an IBAN that is correct from FRANCE"
validateIBAN_NewXML($IBAN; ->$errCode; ->$bankName; ->$countryCode; ->$city; ->$address; ->$BIC; ->$validCheckSum)
$expected:=""
$should:="not produce any errorcode and return an empty string"
AJ_assert($test; $errCode; $expected; $given; $should)
$expected:="CREDIT AGRICOLE S A"
$should:="return bank name: "+$expected
AJ_assert($test; $bankName; $expected; $given; $should)
$expected:="FR"
$should:="return country code: "+$expected
AJ_assert($test; $countryCode; $expected; $given; $should)
$expected:="MONTROUGE CEDEX"
$should:="return city: "+$expected
AJ_assert($test; $city; $expected; $given; $should)
$expected:="12 PL DES ETATS UNIS"
$should:="retun address: "+$expected
AJ_assert($test; $address; $expected; $given; $should)
$expected:="AGRIFRPPXXX"
$should:="return BIC: "+$expected
AJ_assert($test; $BIC; $expected; $given; $should)
$expected:="Account Number check digit is correct"
$should:="return message: "+$expected
AJ_assert($test; $validCheckSum; $expected; $given; $should)
// -----------------------------------------------------

// PROVIDING A CORRENT IBAN - UK
$IBAN:="GB33BUKB20201555555555"
$given:="Provinding an IBAN that is correct from United Kingdom"
validateIBAN_NewXML($IBAN; ->$errCode; ->$bankName; ->$countryCode; ->$city; ->$address; ->$BIC; ->$validCheckSum)
$expected:=""
$should:="not produce any errorcode and return an empty string"
AJ_assert($test; $errCode; $expected; $given; $should)
$expected:="BARCLAYS BANK UK PLC"
$should:="return bank name: "+$expected
AJ_assert($test; $bankName; $expected; $given; $should)
$expected:="GB"
$should:="return country code: "+$expected
AJ_assert($test; $countryCode; $expected; $given; $should)
$expected:="Leicester"
$should:="return city: "+$expected
AJ_assert($test; $city; $expected; $given; $should)
$expected:=" "
$should:="retun address: "+$expected
AJ_assert($test; $address; $expected; $given; $should)
$expected:="BUKBGB22XXX"
$should:="return BIC: "+$expected
AJ_assert($test; $BIC; $expected; $given; $should)
$expected:="Account Number check digit is correct"
$should:="return message: "+$expected
AJ_assert($test; $validCheckSum; $expected; $given; $should)
// -----------------------------------------------------

// PROVIDING AN IBAN CODE THAT IS PARTIALLY CORRENT
$IBAN:="FR7630006000011234567890189A"
$given:="Provinding an IBAN that is partially correct"
validateIBAN_NewXML($IBAN; ->$errCode; ->$bankName; ->$countryCode; ->$city; ->$address; ->$BIC; ->$validCheckSum)
$expected:=" 1. IBAN Check digit not correct. 2. IBAN structure is not correct. 3. IBAN Length is not correct. France IBAN must be 27 characters long.."
$should:="produce and error code providing all issues"
AJ_assert($test; $errCode; $expected; $given; $should)
$expected:=""
$should:="return empty string"
AJ_assert($test; $bankName; $expected; $given; $should)
$expected:="FR"
$should:="return country code: "+$expected
AJ_assert($test; $countryCode; $expected; $given; $should)
$expected:=""
$should:="return empty string"
AJ_assert($test; $city; $expected; $given; $should)
$expected:=""
$should:="return empty string"
AJ_assert($test; $address; $expected; $given; $should)
$expected:=""
$should:="return empty string"
AJ_assert($test; $BIC; $expected; $given; $should)
$expected:="Account Number check digit is correct"
$should:="return message: "+$expected
AJ_assert($test; $validCheckSum; $expected; $given; $should)
// -----------------------------------------------------

// PROVIDING AN IBAN CODE THAT IS COMPLETELY INCORRENT
$IBAN:="!@#$%^&*()"
$given:="Provinding an IBAN that is partially correct"
validateIBAN_NewXML($IBAN; ->$errCode; ->$bankName; ->$countryCode; ->$city; ->$address; ->$BIC; ->$validCheckSum)
$expected:=" 1. IBAN contains illegal characters. 2. IBAN Check digit not correct. 3. IBAN structure is not correct."
$should:="produce and error code providing all issues"
AJ_assert($test; $errCode; $expected; $given; $should)
$expected:=""
$should:="return empty string"
AJ_assert($test; $bankName; $expected; $given; $should)
$expected:=""
$should:="return empty string"
AJ_assert($test; $countryCode; $expected; $given; $should)
$expected:=""
$should:="return empty string"
AJ_assert($test; $city; $expected; $given; $should)
$expected:=""
$should:="return empty string"
AJ_assert($test; $address; $expected; $given; $should)
$expected:=""
$should:="return empty string"
AJ_assert($test; $BIC; $expected; $given; $should)
$expected:="Account Number check digit is not performed for this bank or branch"
$should:="return message: "+$expected
AJ_assert($test; $validCheckSum; $expected; $given; $should)
// -----------------------------------------------------