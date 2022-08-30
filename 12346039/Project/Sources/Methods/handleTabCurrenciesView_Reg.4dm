//%attributes = {}

//handleTab_CurrenciesViewRegisters
// called from handleTabCurrenciesView
// need optimization

//C_TEXT(vCurrency;vAccount)
C_DATE:C307(vFromDate; vToDate; $vFromDate; $vToDate)
C_LONGINT:C283(cbApplyDateRange)
//
//  // Sum Variable Declarations
//C_REAL(vSumCredits;vSumDebits;vSumBalance)
//C_REAL(vSumOpeningCredits;vSumOpeningDebits;vSumOpeningBalance)
//C_REAL(vSumTotalCredits;vSumTotalDebits;vSumTotalBalance)
//
//C_REAL(vSumCreditsLocal;vSumDebitsLocal;vSumBalanceLocal)
//C_REAL(vSumOpeningCreditsLocal;vSumOpeningDebitsLocal;vSumOpeningBalanceLocal)
//C_REAL(vSumTotalCreditsLocal;vSumTotalDebitsLocal;vSumTotalBalanceLocal)
//
//  // Fees Variable Declarations
//C_REAL(vSumFees;vSumOpeningFees;vSumTotalFees)
//
//vCurrency:=[Currencies]CurrencyCode

C_TEXT:C284($currency)
$currency:=[Currencies:6]CurrencyCode:1

If (cbApplyDateRange=1)
	$vFromDate:=vFromDate
	$vToDate:=vToDate
Else 
	$vFromDate:=Date:C102("00/00/00")
	$vToDate:=Current date:C33
End if 

// 1ST : query a single currency 
QUERY:C277([Registers:10]; [Registers:10]Currency:19=$currency)
// 2ND : constrain the ending period
QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$vFromDate; *)  // combined the query
QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$vToDate)

// 3RD: calculate the sum from beginning to toDate
//getRegisterSums (->vSumTotalDebitsLocal;->vSumTotalCreditsLocal;->vSumTotalBalanceLocal;->vSumTotalDebits;->vSumTotalCredits;->vSumTotalBalance;->vSumTotalFees)

// 4TH: constrain the starting period


// 5TH: calculate the other sums
//getRegisterSums (->vSumDebitsLocal;->vSumCreditsLocal;->vSumBalanceLocal;->vSumDebits;->vSumCredits;->vSumBalance;->vSumFees)

//calcSummaryVars 
orderByRegisters
