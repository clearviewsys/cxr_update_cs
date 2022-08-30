//%attributes = {}
//print2LevelBreakTable (->[MainAccounts];->[Accounts];->[Accounts]MainAccountID;->[Accounts]AccountID;->[Accounts]isReservedBySystem)
//print2LevelBreakTable (->[MainAccounts];->[Accounts];->[Accounts]MainAccountID;->[Accounts]Currency;->[Accounts]OpeningDebit)


C_DATE:C307(vfromDate; vToDate)
C_LONGINT:C283(vRowNumber)
C_TEXT:C284($formName; $methodName; $reportName)
$formName:="print"
$methodName:="calcMainAccountsLineVars"
$reportName:="Ledger Accounts Summary"
vFromDate:=Current date:C33
vToDate:=Current date:C33


printSettings
ORDER BY:C49([MainAccounts:28]; [MainAccounts:28]AccountType:4; >; [MainAccounts:28]MainAccountID:1; >)
If (OK=1)
	printFormsTable(->[MainAccounts:28]; ->[MainAccounts:28]AccountType:4; $formName; $methodName; $reportName; True:C214; True:C214; True:C214; False:C215)
End if 

