//%attributes = {}
// WARNING : THE ORDER OF SUM is very important in this method
// if you move around the queries you may end up with unexpected results
// *************************************************************************

// 
C_TEXT:C284(vCurrency; vAccount; $accounts)
C_DATE:C307(vFromDate; vToDate)

// Sum Variable Declarations
C_REAL:C285(vSumCredits; vSumDebits; vSumBalance)
C_REAL:C285(vSumOpeningCredits; vSumOpeningDebits; vSumOpeningBalance)
C_REAL:C285(vSumTotalCredits; vSumTotalDebits; vSumTotalBalance)

C_REAL:C285(vSumCreditsLocal; vSumDebitsLocal; vSumBalanceLocal)
C_REAL:C285(vSumOpeningCreditsLocal; vSumOpeningDebitsLocal; vSumOpeningBalanceLocal)
C_REAL:C285(vSumTotalCreditsLocal; vSumTotalDebitsLocal; vSumTotalBalanceLocal)

// Fees Variable Declarations
C_REAL:C285(vSumFees; vSumOpeningFees; vSumTotalFees)

// Tax Variable Declarations
C_REAL:C285(vOpeningTax1Received; vOpeningTax1Paid; vOpeningTax1Balance)
C_REAL:C285(vPeriodTax1Received; vPeriodTax1Paid; vPeriodTax1Balance)
C_REAL:C285(vSumTax1Received; vSumTax1Paid; vSumTax1Balance)

C_REAL:C285(vOpeningtax2Received; vOpeningtax2Paid; vOpeningtax2Balance)
C_REAL:C285(vPeriodtax2Received; vPeriodtax2Paid; vPeriodtax2Balance)
C_REAL:C285(vSumtax2Received; vSumtax2Paid; vSumtax2Balance)

C_REAL:C285(vOpeningTaxesReceived; vOpeningTaxesPaid; vOpeningTaxesBalance)
C_REAL:C285(vPeriodTaxesReceived; vPeriodTaxesPaid; vPeriodTaxesBalance)
C_REAL:C285(vSumTaxesReceived; vSumTaxesPaid; vSumTaxesBalance)

$accounts:="@"+vAccount+"@"

QUERY:C277([Accounts:9]; [Accounts:9]Currency:6=vCurrency; *)
QUERY:C277([Accounts:9];  & ; [Accounts:9]AccountID:1=$accounts)

// FIRST : query a single currency (cause adding up multiple currencies doesn't make sense)
// SECOND : query selection that matches the account description

If (vAccount="")
	QUERY:C277([Registers:10]; [Registers:10]Currency:19=vCurrency)
Else 
	QUERY:C277([Registers:10]; [Registers:10]Currency:19=vCurrency; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]AccountID:6=$accounts)
End if 

// THIRD : constrain the ending period
QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)

// FOURTH: calculate the sum from beginning to toDate
getRegisterSums(->vSumTotalDebitsLocal; ->vSumTotalCreditsLocal; ->vSumTotalBalanceLocal; ->vSumTotalDebits; ->vSumTotalCredits; ->vSumTotalBalance; ->vSumTotalFees)
getRegistersTaxSums(->vSumTax1Received; ->vSumTax1Paid; ->vSumTax1Balance; ->vSumtax2Received; ->vSumtax2Paid; ->vSumtax2Balance)

// FIFTH: constrain the starting period
QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate)

// SIXTH: calculate the other sums
getRegisterSums(->vSumDebitsLocal; ->vSumCreditsLocal; ->vSumBalanceLocal; ->vSumDebits; ->vSumCredits; ->vSumBalance; ->vSumFees)
getRegistersTaxSums(->vPeriodTax1Received; ->vPeriodTax1Paid; ->vPeriodTax1Balance; ->vPeriodtax2Received; ->vPeriodtax2Paid; ->vPeriodtax2Balance)

calcSummaryVars

orderByRegisters