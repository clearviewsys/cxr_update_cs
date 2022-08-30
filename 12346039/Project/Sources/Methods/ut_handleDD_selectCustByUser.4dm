//%attributes = {"shared":true}
// __UNIT_TEST
// @tiran
// testing a dropdown controller to select records based on the user that created it
// Jan 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("handleDD_selectRecordByUser"; Current method name:C684; "Controllers.DropDown")
// handleDD_selectRecordByUser

START TRANSACTION:C239
C_LONGINT:C283($false)
$false:=0

ALL RECORDS:C47([Users:25])
DELETE SELECTION:C66([Users:25])

// first test with a null widget
C_POINTER:C301($widgetPtr)

handleDD_SelectRecordsByUser($widgetPtr; ->[Customers:3]; ->[Customers:3]CreatedByUserID:58)
AJ_assert($test; $widgetPtr=Null:C1517; True:C214; "calling method a null pointer"; "the method should not crash")

ARRAY TEXT:C222($arrText; 0)
C_TEXT:C284($given)
handleDD_SelectRecordsByUser(->$arrText; ->[Customers:3]; ->[Customers:3]CreatedByUserID:58; $false; On Load:K2:1)
$given:="passing an empty array with on load form event"
AJ_assert($test; Size of array:C274($arrText); 2; $given; "we should get back an array with size 2")
AJ_assert($test; $arrText{1}; "Users..."; $given; "we should get back 'Users...' in the first element")
AJ_assert($test; $arrText{2}; "Administrator"; $given; "we should get back 'Administrator' in the second element")


CREATE RECORD:C68([Users:25])  // create a record
[Users:25]UserName:3:="testUser1"
[Users:25]isInactive:18:=False:C215
SAVE RECORD:C53([Users:25])

$given:="adding record 'testUser1' into the Users table"
handleDD_SelectRecordsByUser(->$arrText; ->[Customers:3]; ->[Customers:3]CreatedByUserID:58; $false; On Load:K2:1)  // load the array again; now it should have three elements (including the default line)
AJ_assert($test; Size of array:C274($arrText); 3; $given; "we should get back an array with size 3")
AJ_assert($test; $arrText{1}; "Users..."; $given; "we should get back 'Users...' in the first element")
AJ_assert($test; $arrText{2}; "Administrator"; $given; "we should get back 'Administrator' in the second element")
AJ_assert($test; $arrText{3}; "testUser1"; $given; "we should get back 'testUser1' in the third element")


CREATE RECORD:C68([Users:25])  // create a record
[Users:25]UserName:3:="testUser2"
[Users:25]isInactive:18:=False:C215
SAVE RECORD:C53([Users:25])


$given:="adding record 'testUser2' into the Users table"
handleDD_SelectRecordsByUser(->$arrText; ->[Customers:3]; ->[Customers:3]CreatedByUserID:58; $false; On Load:K2:1)  // load the array again; now it should have three element (including the default line)
AJ_assert($test; Size of array:C274($arrText); 4; $given; "we should get back an array with size 4")


CREATE RECORD:C68([Users:25])  // create a record
[Users:25]UserName:3:="testUser3"
[Users:25]isInactive:18:=True:C214
SAVE RECORD:C53([Users:25])

$given:="adding record 'testUser3' into the Users table who is inactive"
handleDD_SelectRecordsByUser(->$arrText; ->[Customers:3]; ->[Customers:3]CreatedByUserID:58; $false; On Load:K2:1)  // load the array again; now it should have three element (including the default line)
AJ_assert($test; Size of array:C274($arrText); 4; $given; "we should get back an array with size 4")


// now add a customer with CreatedByUserID set to testUser1

CREATE RECORD:C68([Customers:3])  // create a record
[Customers:3]CreatedByUserID:58:="testUser1"
[Customers:3]FullName:40:="John Doe"
SAVE RECORD:C53([Customers:3])

CREATE RECORD:C68([Customers:3])  // create a record
[Customers:3]CreatedByUserID:58:="testUser1"
[Customers:3]FullName:40:="Jane Doe"
SAVE RECORD:C53([Customers:3])

// Test Clicking on different users in the Drop Down

$given:="selecting the 4th element in the array"
$arrText:=4  // select the fouth element from the array (testUser1)
AJ_assert($test; $arrText{$arrText}; "testUser1"; $given; "we should get 'testUser1' as the 4th element")
handleDD_SelectRecordsByUser(->$arrText; ->[Customers:3]; ->[Customers:3]CreatedByUserID:58; $false; On Clicked:K2:4)  // click on the 'testUser1' user
$given:="running the handler method on clicked when the 'testUser1' element is selected"
AJ_assert($test; Records in selection:C76([Customers:3]); 2; $given; "we should get 2 customers matching that user")

//$arrText:=1  // select the "Users..." element from the array 
handleDD_SelectRecordsByUser(->$arrText; ->[Customers:3]; ->[Customers:3]CreatedByUserID:58; $false; On Clicked:K2:4)  // clicking on the user... element should not change the selection
$given:="running the handler method on clicked when the \"Users...\" item is selected"
AJ_assert($test; Records in selection:C76([Customers:3]); 2; $given; "we should get 2 customers selected based on our previous selection")

$given:="selecting the 3th element in the array"
$arrText:=3  // select the third element from the array (testUser2)
AJ_assert($test; $arrText{$arrText}; "testUser2"; $given; "we should get 'testUser2' as the 3th element")
handleDD_SelectRecordsByUser(->$arrText; ->[Customers:3]; ->[Customers:3]CreatedByUserID:58; $false; On Clicked:K2:4)  // click on the 'testUser2' user
$given:="running the handler method on clicked when the 'testUser2' element is selected"
AJ_assert($test; Records in selection:C76([Customers:3]); 0; $given; "we should get 0 customers matching that user")


CANCEL TRANSACTION:C241
