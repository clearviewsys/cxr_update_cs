//%attributes = {"shared":true}
// __UNIT_TEST
// Jan 2021

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("isFieldUnique"; Current method name:C684; "Validation")
// ut_
// testing isFieldUnique

START TRANSACTION:C239

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="AAA"
[Customers:3]FullName:40:="John Doe"
[Customers:3]Email:17:="johndoe@nomail.com"
//ASSERT(isFieldUnique(->[Customers]Email;->[Customers]CustomerID)=True;"email should be unique")
AJ_assert($test; isFieldUnique(->[Customers:3]Email:17; ->[Customers:3]CustomerID:1); True:C214; "johndoe@nomail.com as email"; "be unique")
SAVE RECORD:C53([Customers:3])

// there are no records with the same AAA customer ID

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="BBB"
[Customers:3]FullName:40:="Jane Doe"
[Customers:3]Email:17:="janedoe@nomail.com"
AJ_assert($test; isFieldUnique(->[Customers:3]Email:17; ->[Customers:3]CustomerID:1); True:C214; "janedoe@nomail.com"; "email should be unique")
SAVE RECORD:C53([Customers:3])


CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="CCC"
[Customers:3]FullName:40:="Janette Doe"
[Customers:3]Email:17:="janedoe@nomail.com"
AJ_assert($test; isFieldUnique(->[Customers:3]Email:17; ->[Customers:3]CustomerID:1); False:C215; "given janedoe@nomail.com"; "email is not unique anymore.")
SAVE RECORD:C53([Customers:3])


CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="CCC"
[Customers:3]FullName:40:="Jane simon Doe"
[Customers:3]Email:17:="janedoesimon@nomail.com"
AJ_assert($test; isFieldUnique(->[Customers:3]Email:17; ->[Customers:3]CustomerID:1); True:C214; "given janedoe@nomail.com"; "email is not unique anymore.")
SAVE RECORD:C53([Customers:3])


AJ_assert($test; ds:C1482.Customers.query("Email === 'janedoe@nomail.com'").length; 2; "a query with email janedoes@nomail.com"; "return 2 matches")

// two people with the same emails
// there are three people with unique customer IDs

CANCEL TRANSACTION:C241