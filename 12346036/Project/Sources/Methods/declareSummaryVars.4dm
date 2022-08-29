//%attributes = {}
C_TEXT:C284(vCurrency; vAccount; $accounts)
C_DATE:C307(vFromDate; vToDate)

// Sum Variable Declarations
C_REAL:C285(vSumCredits; vSumDebits; vSumBalance)
C_REAL:C285(vSumOpeningCredits; vSumOpeningDebits; vSumOpeningBalance)
C_REAL:C285(vSumTotalCredits; vSumTotalDebits; vSumTotalBalance)

C_REAL:C285(vSumCreditsLocal; vSumDebitsLocal; vSumBalanceLocal)
C_REAL:C285(vSumOpeningCreditsLocal; vSumOpeningDebitsLocal; vSumOpeningBalanceLocal)
C_REAL:C285(vSumTotalCreditsLocal; vSumTotalDebitsLocal; vSumTotalBalanceLocal)

C_REAL:C285(vSubtotalBalanceLocal)

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

C_BOOLEAN:C305(onPrintingBreak)  // set this in the break form 
//onPrintingBreak:=False  ` only for break processing during print

C_REAL:C285(vSumTransferIns; vSumTransferOuts; vSumTransfers)

C_REAL:C285(vMarketRate; vMarketValue; vSumMarketValues)

C_REAL:C285(vTotalPosition)

C_REAL:C285(vSubTotalCredits; vSubTotalDebits; vSubTotalFees)

C_REAL:C285(vSubTotalDebits; vSubtotalCredits; vSubTotalBalance)

C_REAL:C285(vSubTotalUnrealizedGains; vUnrealizedGains; vTotalUnrealizedGains)