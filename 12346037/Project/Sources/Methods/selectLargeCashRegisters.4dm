//%attributes = {}
// selectLargeCashRegisters
// this method select all incoming cash transactions over "LCT"
// assume : should not select "self" transactions"
// should not select companies
// only incoming cash transactions should be selected
// the debit should be positive, and the debitlocal should be greater than limit
// the transaction must be cash only

SET AUTOMATIC RELATIONS:C310(True:C214)
QUERY SELECTION:C341([Registers:10]; [Customers:3]isCompany:41=False:C215)  // find only registers related to non-companies
QUERY SELECTION:C341([Registers:10]; [Registers:10]CustomerID:5#getSelfCustomerID)  // filter-out our own invoices

QUERY SELECTION:C341([Registers:10]; [Registers:10]DebitLocal:23>=<>declarationFormLimit)


//QUERY SELECTION([Registers];[Registers]DebitLocal>=◊declarationFormLimit;*)
//QUERY SELECTION([Registers]; | ;[Registers]CreditLocal>=◊declarationFormLimit)

SET AUTOMATIC RELATIONS:C310(False:C215)