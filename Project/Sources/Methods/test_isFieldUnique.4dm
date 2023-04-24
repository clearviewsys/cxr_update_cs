//%attributes = {}


// testing isFieldUnique

START TRANSACTION:C239

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="AAA"
[Customers:3]FullName:40:="John Doe"
[Customers:3]Email:17:="johndoe@nomail.com"
ASSERT:C1129(isFieldUnique(->[Customers:3]Email:17; ->[Customers:3]CustomerID:1)=True:C214; "email should be unique")
SAVE RECORD:C53([Customers:3])

// there are no records with the same AAA customer ID

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="BBB"
[Customers:3]FullName:40:="Jane Doe"
[Customers:3]Email:17:="janedoe@nomail.com"
ASSERT:C1129(isFieldUnique(->[Customers:3]Email:17; ->[Customers:3]CustomerID:1)=True:C214; "email should be unique")
SAVE RECORD:C53([Customers:3])


CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="CCC"
[Customers:3]FullName:40:="Janette Doe"
[Customers:3]Email:17:="janedoe@nomail.com"
ASSERT:C1129(isFieldUnique(->[Customers:3]Email:17; ->[Customers:3]CustomerID:1)=False:C215; "email is not unique")
SAVE RECORD:C53([Customers:3])

// two people with the same emails
// there are three people with unique customer IDs

CANCEL TRANSACTION:C241