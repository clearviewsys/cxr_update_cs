//%attributes = {"shared":true}
// _UNIT_TEST
// this method is not unit testable with the AJ component as it displays UX 

C_OBJECT:C1216($test; $testObject)
//C_TEXT($given)
$test:=AJ_UnitTest.new("Customer Name Compliance"; Current method name:C684; "Sanction Check")
C_TEXT:C284($fullName)
//C_POINTER($nullPtr)
C_LONGINT:C283($testCustomer; $testOutput; $match)
$fullName:="Abu Mariam"
$testObject:=New object:C1471
//$testObject:=handleCustomerNameCompliance(True;$fullName)
//clearPictureField($testObject)

//C_OBJECT($testObject)


//$testOutput:= $testObject
//If ($testObject=2)
//$testOutput:=2
//End if 

//sl_getSanctionListResultMsg ($match)

AJ_assert($test; $testOutput; 2; " Abu Mariam"; "demonstrate name on the list")

/*$test:=AJ_UnitTest.new("Customer Name Compliance";Current method name;"Sanction Check")


//test method 1
C_LONGINT($testCustomer)
$testName:=makeFullName("Abu";"Mariam")
$logIdPtr:=->[Customers]CustomerID
$resultIcon:=->latestCheckStatus1
C_TEXT($resultText;$query)
$resultText:=""
$query:=""

//$fullName:=makeFullName([Customers]FirstName;[Customers]LastName)
$more:=New object

$options:=New object
$options.ignorePEP:=False
$options.list:=""
$options.query:=""
$options.namePartsFilled:=True
$options.autoList:=""
$more.options:=$options

$pointers:=New object
$pointers.resultIconPtr:=->latestCheckStatus1
$pointers.resultTextPtr:=->$resultText
$more.pointers:=$pointers


$testCustomer:=handleCustomerNameCompliance(True;$testName;$logIdPtr;$more)

/*$more:=New object

$options:=New object

C_OBJECT($expectedObj)
$expectedObj:= CheckSanctionCheckListSetIcon($isForced;$fullName;False;Table($logIdPtr);$logIdPtr->;\
$more.pointers.resultIconPtr;\
$more.options.list;\
$more.pointers.resultTextPtr;->$resultWithoutPEP;\
$more.options.autoList)
*/

AJ_assert($test;$testCustomer;2;" Abu Mariam";"demonstrate name on the list")



//test method 2
C_LONGINT($testCustomer)
$testName:=makeFullName("zjd";"kfkdf")
$logIdPtr:=->[Customers]CustomerID
$resultIcon:=->latestCheckStatus1
C_TEXT($resultText;$query)
$resultText:=""
$query:=""

//$fullName:=makeFullName([Customers]FirstName;[Customers]LastName)
$more:=New object

$options:=New object
$options.ignorePEP:=False
$options.list:=""
$options.query:=""
$options.namePartsFilled:=True
$options.autoList:=""
$more.options:=$options

$pointers:=New object
$pointers.resultIconPtr:=->latestCheckStatus1
$pointers.resultTextPtr:=->$resultText
$more.pointers:=$pointers


$testCustomer:=handleCustomerNameCompliance(True;$testName;$logIdPtr;$more)

/*$more:=New object

$options:=New object

C_OBJECT($expectedObj)
$expectedObj:= CheckSanctionCheckListSetIcon($isForced;$fullName;False;Table($logIdPtr);$logIdPtr->;\
$more.pointers.resultIconPtr;\
$more.options.list;\
$more.pointers.resultTextPtr;->$resultWithoutPEP;\
$more.options.autoList)
*/

AJ_assert($test;$testCustomer;0;" zjd kfkdf";"not find on the list")


//test method 2
C_LONGINT($testCustomer)
$testName:=makeFullName("Omar";"Hmmami")
$logIdPtr:=->[Customers]CustomerID
$resultIcon:=->latestCheckStatus1
C_TEXT($resultText;$query)
$resultText:=""
$query:=""

//$fullName:=makeFullName([Customers]FirstName;[Customers]LastName)
$more:=New object

$options:=New object
$options.ignorePEP:=False
$options.list:=""
$options.query:=""
$options.namePartsFilled:=True
$options.autoList:=""
$more.options:=$options

$pointers:=New object
$pointers.resultIconPtr:=->latestCheckStatus1
$pointers.resultTextPtr:=->$resultText
$more.pointers:=$pointers


$testCustomer:=handleCustomerNameCompliance(True;$testName;$logIdPtr;$more)

/*$more:=New object

$options:=New object

C_OBJECT($expectedObj)
$expectedObj:= CheckSanctionCheckListSetIcon($isForced;$fullName;False;Table($logIdPtr);$logIdPtr->;\
$more.pointers.resultIconPtr;\
$more.options.list;\
$more.pointers.resultTextPtr;->$resultWithoutPEP;\
$more.options.autoList)
*/

AJ_assert($test;$testCustomer;2;" Omar Hammami";"demonstrate name on the list")
*/
