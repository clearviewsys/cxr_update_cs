//%attributes = {"shared":true}
// __UNIT_TEST
// written by @viktor
//Jan 2021

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("isCustomerOkToEmail"; Current method name:C684; "Notifications.Email")
// isCustomerOkToEmail

C_TEXT:C284($customerID)
C_TEXT:C284($given; $should)
C_BOOLEAN:C305($isOkToEmail)

START TRANSACTION:C239

// CREATE CUSTOMER WITH NO EMAIL
CREATE RECORD:C68([Customers:3])  // create Customer record
[Customers:3]Email:17:=""
[Customers:3]FirstName:3:="isCustomerOkToEmail1"
SAVE RECORD:C53([Customers:3])
$customerID:=ds:C1482.Customers.query("FirstName='isCustomerOkToEmail1'").first().CustomerID
$given:="A customer with a blank Email address"
$should:="return false, customer is not ok to email"
$isOkToEmail:=isCustomerOKToEmail($customerID)
AJ_assert($test; $isOkToEmail; False:C215; $given; $should)

// CREATE CUSTOMER ON HOLD
CREATE RECORD:C68([Customers:3])  // create Customer record
[Customers:3]isOnHold:52:=True:C214
[Customers:3]FirstName:3:="isCustomerOkToEmail2"
SAVE RECORD:C53([Customers:3])
$customerID:=ds:C1482.Customers.query("FirstName='isCustomerOkToEmail2'").first().CustomerID
$given:="A customer who is on hold"
$should:="return false, customer is not ok to email"
$isOkToEmail:=isCustomerOKToEmail($customerID)
AJ_assert($test; $isOkToEmail; False:C215; $given; $should)

// CREATE CUSTOMER WHO OPTED OUT OF EMAIL MARKETING
CREATE RECORD:C68([Customers:3])  // create Customer record
[Customers:3]optInEmail:149:=2
[Customers:3]FirstName:3:="isCustomerOkToEmail3"
SAVE RECORD:C53([Customers:3])
$customerID:=ds:C1482.Customers.query("FirstName='isCustomerOkToEmail3'").first().CustomerID
$given:="A customer who opted out of email marketing"
$should:="return false, customer is not ok to email"
$isOkToEmail:=isCustomerOKToEmail($customerID)
AJ_assert($test; $isOkToEmail; False:C215; $given; $should)

// CREATE CUSTOMER WHO IS AN INSIDER
CREATE RECORD:C68([Customers:3])  // create Customer record
[Customers:3]isInsider:102:=True:C214
[Customers:3]FirstName:3:="isCustomerOkToEmail4"
SAVE RECORD:C53([Customers:3])
$customerID:=ds:C1482.Customers.query("FirstName='isCustomerOkToEmail4'").first().CustomerID
$given:="A customer who is an insider"
$should:="return false, customer is not ok to email"
$isOkToEmail:=isCustomerOKToEmail($customerID)
AJ_assert($test; $isOkToEmail; False:C215; $given; $should)

// CREATE CUSTOMER WHO IS NO LONGER IN BUSINESS RELATION
CREATE RECORD:C68([Customers:3])  // create Customer record
[Customers:3]AML_isInBusinessRelation:115:=2
[Customers:3]FirstName:3:="isCustomerOkToEmail5"
SAVE RECORD:C53([Customers:3])
$customerID:=ds:C1482.Customers.query("FirstName='isCustomerOkToEmail5'").first().CustomerID
$given:="A customer who is no longer in business relation"
$should:="return false, customer is not ok to email"
$isOkToEmail:=isCustomerOKToEmail($customerID)
AJ_assert($test; $isOkToEmail; False:C215; $given; $should)

// CREATE CUSTOMER WHO IS "WALKIN"
CREATE RECORD:C68([Customers:3])  // create Customer record
[Customers:3]isWalkin:36:=True:C214
[Customers:3]FirstName:3:="isCustomerOkToEmail6"
SAVE RECORD:C53([Customers:3])
$customerID:=ds:C1482.Customers.query("FirstName='isCustomerOkToEmail6'").first().CustomerID
$given:="A customer who is 'Walkin' customer"
$should:="return false, customer is not ok to email"
$isOkToEmail:=isCustomerOKToEmail($customerID)
AJ_assert($test; $isOkToEmail; False:C215; $given; $should)

// CREATE CUSTOMER WHO IS OK TO EMAIL
CREATE RECORD:C68([Customers:3])  // create Customer record
[Customers:3]Email:17:="noreplyy@clearviewsys.com"
[Customers:3]isOnHold:52:=False:C215
[Customers:3]isInsider:102:=False:C215
[Customers:3]optInEmail:149:=1
[Customers:3]FirstName:3:="isCustomerOkToEmail7"
SAVE RECORD:C53([Customers:3])
$customerID:=ds:C1482.Customers.query("FirstName='isCustomerOkToEmail7'").first().CustomerID
$given:="A customer who is ok to email"
$should:="return true, customer is ok to email"
$isOkToEmail:=isCustomerOKToEmail($customerID)
AJ_assert($test; $isOkToEmail; True:C214; $given; $should)

CANCEL TRANSACTION:C241