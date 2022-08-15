//%attributes = {}
C_DATE:C307(vFromDate; vToDate; $vFromDate; $vToDate)
C_LONGINT:C283(cbApplyDateRange)

C_REAL:C285(vSumDebits; vSumCredits; vSumBalances)
QUERY:C277([Accounts:9]; [Accounts:9]Currency:6=[Currencies:6]CurrencyCode:1)
RELATE MANY SELECTION:C340([Registers:10]AccountID:6)  // select the accounts 
filterRegistersInDateRange(vFromDate; vToDate; numToBoolean(cbApplyDateRange))
C_REAL:C285(vSumDebits; vSumCredits; vSumBalances; vSumDebitsLocal; vSumCreditsLocal; vSumBalancesLocal)
getRegisterSums(->vSumDebitsLocal; ->vSumCreditsLocal; ->vSumBalancesLocal; ->vSumDebits; ->vSumCredits; ->vSumBalances)
