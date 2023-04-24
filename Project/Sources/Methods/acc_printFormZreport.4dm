//%attributes = {}
C_TEXT:C284($formName; $onPrintingDetailMethod; $reportName; $onPrintingBreakMethod)
C_REAL:C285(vTotalDebitsLocal; vTotalCreditsLocal; vTotalFees)
C_LONGINT:C283(sv_NumOfCashReceipts; sv_NumOfFailedReceipts; sv_ZreportSerial)
C_TEXT:C284(vCurrentVersion)


$reportName:="Z Report"
$formName:="rep_XZreport"
$onPrintingDetailMethod:="calcAccountsRepLineVars"
$onPrintingBreakMethod:="acc_printFormBreakMethod"

vTotalDebitsLocal:=0
vTotalCreditsLocal:=0
vTotalFees:=0


vCurrentVersion:=getCurrentVersion
sv_NumOfCashReceipts:=SV_getNumOfCashReceiptsToday
sv_NumOfFailedReceipts:=SV_getNumOfFailedReceiptsToday
sv_ZreportSerial:=getTableNextSerialNo(->[ZReport:76])

acc_printFormBreakMethod  // reset the break sum variables
printFormsTable(->[Accounts:9]; ->[Accounts:9]MainAccountID:2; $formName; $onPrintingDetailMethod; $reportName; True:C214; True:C214; True:C214; True:C214; $onPrintingBreakMethod)
