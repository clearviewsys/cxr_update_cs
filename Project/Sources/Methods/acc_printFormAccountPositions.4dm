//%attributes = {}
C_TEXT:C284($formName; $onPrintingDetailMethod; $reportName; $onPrintingBreakMethod)
$formName:="rep_AccountPositions"

$onPrintingDetailMethod:="calcAccountsRepLineVars"
$reportName:="Account Positions from "+String:C10(vFromDate)+" to "+String:C10(vToDate)
$onPrintingBreakMethod:="acc_printFormBreakMethod"

VTOTALPOSITION:=0
acc_printFormBreakMethod  // reset the break sum variables

printFormsTable(->[Accounts:9]; ->[Accounts:9]MainAccountID:2; $formName; $onPrintingDetailMethod; $reportName; True:C214; True:C214; True:C214; True:C214; $onPrintingBreakMethod)

