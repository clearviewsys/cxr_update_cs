//%attributes = {}
// handlePrintKYC ApplicationForm
// this will print the KYC application form
// this method was originally developed for MoneyWay and hence there is an exception 
// PRE: the customer record should be loaded
// POST: 

C_TEXT:C284($formName)
$formName:=getKeyValue("KYC.ApplicationForm"; "Customer_AppForm")
If (Position:C15(<>CompanyName; "MoneyWay")>0)
	$formName:=$formName+"_MW"
End if 

printRecordUsingPrinter(->[Customers:3]; $formName)
