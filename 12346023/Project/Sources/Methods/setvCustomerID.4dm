//%attributes = {}
// setvCustomerID (string)
// use this method to assign the customerID in invoice
C_TEXT:C284(vCustomerID; $1; vCustomerGroup)
vCustomerID:=$1
[Invoices:5]CustomerID:2:=vCustomerID
RELATE ONE:C42([Invoices:5]CustomerID:2)
vCustomerGroup:=[Customers:3]GroupName:90

//enableButtonIf ((countCustomerPictureIDs (vCustomerID)>0);"bShowPID")

C_REAL:C285($debit; $credit; vCustomerBalanceDue)

handleInvoiceCustomerOws
setInvoiceCustomerFields

