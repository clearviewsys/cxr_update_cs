//%attributes = {}
C_TEXT:C284($formName; $onPrintingDetailMethod; $reportName; $onPrintingBreakMethod)
$reportName:="Ledger and Subledger Account Balances"
$formName:="rep_Accounts"
$onPrintingDetailMethod:="calcAccountsRepLineVars"
$onPrintingBreakMethod:="acc_printFormBreakMethod"
acc_printFormBreakMethod  // reset the break sum variables

printFormsTable(->[Accounts:9]; ->[Accounts:9]MainAccountID:2; $formName; $onPrintingDetailMethod; $reportName; True:C214; True:C214; True:C214; True:C214; $onPrintingBreakMethod)
