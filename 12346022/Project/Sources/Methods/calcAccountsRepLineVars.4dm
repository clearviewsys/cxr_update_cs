//%attributes = {}
// calcAccountsRepLineVars

// WARNING THIS METHOD SHOULD NOT BE RENAMED
// IT HAS BEEN USED IN AN EXECUTE METHOD in printFormsTable


declareSummaryVars  // not sure why we need to do this every single time

RELATE ONE:C42([Accounts:9]Currency:6)  // load the currency related to this account
vMarketRate:=[Currencies:6]SpotRateLocal:17  // maybe THIS LINE SHOULD BE LOOKING FOR THE HISTORICAL SPOT RATE 


// 1ST : load all the registers related to this account 
relateMany(->[Registers:10]; ->[Registers:10]AccountID:6; ->[Accounts:9]AccountID:1)  // load all the registers for this account

// 2ND : select all records until the end date
QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)

// 3RD: calculate the sums from beginning to toDate
getRegisterSums(->vSumTotalDebitsLocal; ->vSumTotalCreditsLocal; ->vSumTotalBalanceLocal; ->vSumTotalDebits; ->vSumTotalCredits; ->vSumTotalBalance; ->vSumTotalFees)

// 4TH: select all the registers starting from the startDate until 
QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate)

// 5TH: calculate the other sums
getRegisterSums(->vSumDebitsLocal; ->vSumCreditsLocal; ->vSumBalanceLocal; ->vSumDebits; ->vSumCredits; ->vSumBalance; ->vSumFees; ->vSumTransferIns; ->vSumTransferOuts; ->vSumUnrealizedGains)

calcSummaryVars

accumulateReal(->vSubtotalBalanceLocal; vSumTotalBalanceLocal)
accumulateReal(->vSumMarketValues; vMarketValue)
accumulateReal(->vTotalPosition; vMarketValue)

accumulateReal(->vSubTotalDebitsLocal; vSumDebitsLocal)
accumulateReal(->vSubTotalCreditsLocal; vSumCreditsLocal)
accumulateReal(->vSubTotalFees; vSumFees)

accumulateReal(->vSubTotalDebits; vSumDebits)
accumulateReal(->vSubTotalCredits; vSumCredits)
accumulateReal(->vSubTotalBalance; vSumTotalBalance)

accumulateReal(->vSubTotalUnrealizedGains; vSumUnrealizedGains)