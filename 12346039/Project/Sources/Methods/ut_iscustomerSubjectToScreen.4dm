//%attributes = {"shared":true}
// __UNIT_TEST
// Author: Wai-Kin Chau
// Jan 2021

START TRANSACTION:C239

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("isCustomerSubjectToScreening"; Current method name:C684; "AML")

READ WRITE:C146([Customers:3])

C_BOOLEAN:C305($result)
CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="_NORMAL_"
SAVE RECORD:C53([Customers:3])
$result:=sl_isCustomerSubjectToScreening([Customers:3]CustomerID:1)
AJ_assert($test; $result; True:C214; "Normal Customer"; "be screened.")

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="_WALKIN_"
[Customers:3]isWalkin:36:=True:C214
SAVE RECORD:C53([Customers:3])
$result:=sl_isCustomerSubjectToScreening([Customers:3]CustomerID:1)
AJ_assert($test; $result; False:C215; "Walk in Customer"; "not be screened")

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="_ACCT_"
[Customers:3]isAccount:34:=True:C214
SAVE RECORD:C53([Customers:3])
$result:=sl_isCustomerSubjectToScreening([Customers:3]CustomerID:1)
AJ_assert($test; $result; False:C215; "Account Customer"; "be screened.")

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="_EXPIRE10_"
[Customers:3]AML_isWhitelisted:131:=True:C214
[Customers:3]AML_WhitelistExpiryDate:130:=Current date:C33-10
SAVE RECORD:C53([Customers:3])
$result:=sl_isCustomerSubjectToScreening([Customers:3]CustomerID:1)
AJ_assert($test; $result; True:C214; "White list customer expired 10 days ago"; "be screened")

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="_EXPIRE1_"
[Customers:3]AML_isWhitelisted:131:=True:C214
[Customers:3]AML_WhitelistExpiryDate:130:=Current date:C33-1
SAVE RECORD:C53([Customers:3])
$result:=sl_isCustomerSubjectToScreening([Customers:3]CustomerID:1)
AJ_assert($test; $result; True:C214; "White list customer expired yesterday"; "be screened")

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="_EXPIRE_TODAY_"
[Customers:3]AML_isWhitelisted:131:=True:C214
[Customers:3]AML_WhitelistExpiryDate:130:=Current date:C33
SAVE RECORD:C53([Customers:3])
$result:=sl_isCustomerSubjectToScreening([Customers:3]CustomerID:1)
AJ_assert($test; $result; True:C214; "White list customer expired today"; "be screened")

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="_EXPIRE_TOMORROW_"
[Customers:3]AML_isWhitelisted:131:=True:C214
[Customers:3]AML_WhitelistExpiryDate:130:=Current date:C33+1
SAVE RECORD:C53([Customers:3])
$result:=sl_isCustomerSubjectToScreening([Customers:3]CustomerID:1)
AJ_assert($test; $result; False:C215; "White list customer expiring tomorrow"; "not be screened")

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="_NOT_EXPIRED"
[Customers:3]AML_isWhitelisted:131:=True:C214
[Customers:3]AML_WhitelistExpiryDate:130:=Current date:C33+10
SAVE RECORD:C53([Customers:3])
$result:=sl_isCustomerSubjectToScreening([Customers:3]CustomerID:1)
AJ_assert($test; $result; False:C215; "White list customer expiring in 10 days"; "not be screened")

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="_NO_KYC_"
[Customers:3]AML_ignoreKYC:35:=True:C214
SAVE RECORD:C53([Customers:3])
$result:=sl_isCustomerSubjectToScreening([Customers:3]CustomerID:1)
AJ_assert($test; $result; False:C215; "No KYC customer"; "not be screened.")

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="_INSIDER_"
[Customers:3]isInsider:102:=True:C214
SAVE RECORD:C53([Customers:3])
$result:=sl_isCustomerSubjectToScreening([Customers:3]CustomerID:1)
AJ_assert($test; $result; False:C215; "Insider / self customer"; "not be screened.")

CREATE RECORD:C68([Customers:3])
[Customers:3]CustomerID:1:="_SERVERAL_"
[Customers:3]isInsider:102:=True:C214
[Customers:3]AML_ignoreKYC:35:=True:C214
SAVE RECORD:C53([Customers:3])
$result:=sl_isCustomerSubjectToScreening([Customers:3]CustomerID:1)
AJ_assert($test; $result; False:C215; "A insider and no KYC customer"; "not be screened.")

CANCEL TRANSACTION:C241
