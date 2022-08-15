//%attributes = {"shared":true}
// __UNIT_TEST
// @Tiran @Zoya
//Feb 2021

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("isCustomerSubToScreening"; Current method name:C684; "AML")


// this method creates some dummy customers first
// ... and then tests to make sure if these customers should be screened for Sanction List or not

START TRANSACTION:C239

READ WRITE:C146([Customers:3])
createDummyCustomers

//ASSERT(isCustomerSubjectToScreening("_WALKIN_")=False; "Walking customer should not be screened")
AJ_assert($test; sl_isCustomerSubjectToScreening("_WALKIN_"); False:C215; "a Walk-in customer"; "not be screened")
//ASSERT(isCustomerSubjectToScreening("_INSIDER_")=False; "Insider customer should not be screened")
AJ_assert($test; sl_isCustomerSubjectToScreening("_INSIDER_"); False:C215; "an Insider customer"; "not be screened")
//ASSERT(isCustomerSubjectToScreening("_self_")=False; "SELF customer should not be screened")
AJ_assert($test; sl_isCustomerSubjectToScreening("_self_"); False:C215; "a SELF customer"; "not be screened")
//ASSERT(isCustomerSubjectToScreening("_ACCT_")=False; "Account customer should not be screened")
AJ_assert($test; sl_isCustomerSubjectToScreening("_ACCT_"); False:C215; "an Account customer"; "not be screened")
//ASSERT(isCustomerSubjectToScreening("_NOKYC_")=False; "NO KYC customer should not be screened")
AJ_assert($test; sl_isCustomerSubjectToScreening("_NOKYC_"); False:C215; "a NO-KYC customer"; "not be screened")
//ASSERT(isCustomerSubjectToScreening("_NORMAL_"); "a normal customer must be screened")
AJ_assert($test; sl_isCustomerSubjectToScreening("_NORMAL_"); True:C214; "a normal customer"; " be screened")
//ASSERT(isCustomerSubjectToScreening("_COMP_"); "a normal company must be screened")
AJ_assert($test; sl_isCustomerSubjectToScreening("_COMP_"); True:C214; "a normal company customer"; " be screened")
// test whitelisted people
AJ_assert($test; sl_isCustomerSubjectToScreening("_WListNoEXP"); False:C215; "a not expired white-listed customer"; "not be screened")
AJ_assert($test; sl_isCustomerSubjectToScreening("_WListEXP"); True:C214; "a expired white-listed customer"; " be screened")
AJ_assert($test; sl_isCustomerSubjectToScreening("_ZeroDateWhite"); True:C214; "a white-listed customer without Date"; " be screened")
AJ_assert($test; sl_isCustomerSubjectToScreening("_NoDateWhite"); True:C214; "a white-listed customer without Date"; " be screened")

AJ_assert($test; sl_isCustomerSubjectToScreening("_WListEXPToday"); True:C214; "a white-listed customer that expires today"; " be screened")

//AJ_assert($test; isCustomerSubjectToScreening("_Not-WHITE-LISTED_"); True; "a not white-listed customer"; " be screened")

//Zoya beleives the following blocks of code does not work this way, 
//as the method sl_isCustomerSubjectToScreening(CustomerID) can not find the customer ID and returns always True
//so Zoya added the "_NewWALKIN" to the method createDummyCustomers, the last two ones can be also added


//CREATE RECORD([Customers])
//[Customers]CustomerID:="_NewWalkin"
//[Customers]isWalkin:=True

//// don't save this record
//AJ_assert($test; sl_isCustomerSubjectToScreening("_NewWALKIN"); False; "a new walkin customer"; " not be screened")

//CREATE RECORD([Customers])
//[Customers]CustomerID:="_NewCustomer"
//// don't save this record
//AJ_assert($test; sl_isCustomerSubjectToScreening([Customers]CustomerID); True; "a new customer"; " be screened")

//CREATE RECORD([Links])
//[Links]LinkID:="_NewLink"
//[Links]FullName:="New Link"
//AJ_assert($test; sl_isCustomerSubjectToScreening([Links]LinkID); True; "A new link"; " be screened")

CANCEL TRANSACTION:C241
