//rep_printAccountBalances (True)

bPrintRecords

//printSettings 

//If (OK=1)
//selectDateRangeTable (->[Registers];->[Registers]RegisterDate;vFromDate;vToDate)
//RELATE ONE SELECTION([Registers];[Accounts])  ` select only the accounts that are related to the registers in that date range
//ORDER BY([Accounts];[Accounts]MainAccountID;>;[Accounts]Currency;>;[Accounts]AccountID;>)  ` order the accounts by their ledger, currency and name
//acc_printFormAccountPositions 
//
//End if 
