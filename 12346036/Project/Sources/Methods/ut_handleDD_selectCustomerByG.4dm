//%attributes = {"shared":true}
// __UNIT_TEST
// written by @tiran
// Jan 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("handleDD_selectCustomersByGroup"; Current method name:C684; "Controllers.DropDown")
// handleDD_selectCustomersByGroup

START TRANSACTION:C239

ALL RECORDS:C47([CustomerTypes:94])
DELETE SELECTION:C66([CustomerTypes:94])  // deleting all customer types

// first test with a null widget
C_POINTER:C301($widgetPtr)

handleDD_selectCustomersByGroup($widgetPtr)
AJ_assert($test; $widgetPtr=Null:C1517; True:C214; "calling method a null pointer"; "the method should not crash")

ARRAY TEXT:C222($arrText; 0)
C_TEXT:C284($given)
handleDD_selectCustomersByGroup(->$arrText; False:C215; On Load:K2:1)
$given:="passing an empty array with on load form event"
AJ_assert($test; Size of array:C274($arrText); 1; $given; "we should get back an array with size 1")
AJ_assert($test; $arrText{1}; "Groups..."; $given; "we should get back Customer Groups... in the first element")

CREATE RECORD:C68([CustomerTypes:94])  // create a record
[CustomerTypes:94]CustomerTypeID:1:="AAA___"
[CustomerTypes:94]Description:2:="Group AAA"
SAVE RECORD:C53([CustomerTypes:94])

$given:="adding  record AAA into the CustomerTypes table"
handleDD_selectCustomersByGroup(->$arrText; False:C215; On Load:K2:1)  // load the array again; now it should have three element (including the default line)
AJ_assert($test; Size of array:C274($arrText); 2; $given; "we should get back an array with size 2")
AJ_assert($test; $arrText{1}; "Groups..."; $given; "we should still have Customer Groups... in the first element")
AJ_assert($test; $arrText{2}; "AAA___"; $given; "second element is AAA")

CREATE RECORD:C68([CustomerTypes:94])  // create a record
[CustomerTypes:94]CustomerTypeID:1:="BBB___"
[CustomerTypes:94]Description:2:="Group BBB"
SAVE RECORD:C53([CustomerTypes:94])

$given:="adding  record BBB into the CustomerTypes table"
handleDD_selectCustomersByGroup(->$arrText; False:C215; On Load:K2:1)  // load the array again; now it should have three element (including the default line)
AJ_assert($test; Size of array:C274($arrText); 3; $given; "we should get back an array with size 3")
AJ_assert($test; $arrText{3}; "BBB___"; $given; "second element is BBB")

// now add a customer with type AAA

CREATE RECORD:C68([Customers:3])  // create a record
[Customers:3]GroupName:90:="AAA___"
[Customers:3]FullName:40:="John Doe"
SAVE RECORD:C53([Customers:3])

CREATE RECORD:C68([Customers:3])  // create a record
[Customers:3]GroupName:90:="AAA___"
[Customers:3]FullName:40:="Jane Doe"
SAVE RECORD:C53([Customers:3])

$arrText:=2  // select the second element from the array 
handleDD_selectCustomersByGroup(->$arrText; False:C215; On Clicked:K2:4)  // load the array again; now it should have three element (including the default line)
$given:="running the handler method on clicked when the 2nd item is selected"
AJ_assert($test; Records in selection:C76([Customers:3]); 2; $given; "we should get 2 customers matching that group")

$arrText:=1  // select the "Customer Groups..." element from the array 
handleDD_selectCustomersByGroup(->$arrText; False:C215; On Clicked:K2:4)  // load the array again; now it should have three element (including the default line)
$given:="running the handler method on clicked when the \"Customer Groups...\" item is selected"
AJ_assert($test; Records in selection:C76([Customers:3]); 2; $given; "we should get 2 customers selected based on our previous selection")

$arrText:=3  // select the third element from the array 
handleDD_selectCustomersByGroup(->$arrText; False:C215; On Clicked:K2:4)  // load the array again; now it should have three element (including the default line)
$given:="running the handler method on clicked when the 3rd item is selected"
AJ_assert($test; Records in selection:C76([Customers:3]); 0; $given; "we should get 0 customers matching that group")

// cases to test
// delete a customer and test again
// test with 'inSelection ' == true



CANCEL TRANSACTION:C241