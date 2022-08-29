//%attributes = {"executedOnServer":true}
//author: Amir
//5th Sept 2018
//calculates account balances for registers that have accountId but no subaccount Id
// getAccountOnlyBalanceInDateRange (accountID; fromDate ; toDate; ->openingBalance;->transferIn;->transferOut; ->sumDebit;->sumCredit; ->balance; ->sumCreditLocal; ->$sumDebitLocal; ->$sumFees; $branchID)
// This method should run on the Server side. So make sure 'Execute on Server' is on
// This method is at least 3 times faster when executed on the server side

C_TEXT:C284($accountID; $1)
C_DATE:C307($fromDate; $toDate; $2; $3)
C_POINTER:C301($openingBalancePtr; $transferInPtr; $transferOutPtr; $sumDebitPtr; $sumCreditPtr; $balancePtr; $4; $5; $6; $7; $8; $9)
C_POINTER:C301($sumCreditLocalPtr; $sumDebitLocalPtr; $10; $11)
C_TEXT:C284($branchID; $12)

C_REAL:C285($sumCreditLocal; $sumDebitLocal; $balanceLocal)

$accountID:=$1
$fromDate:=$2
$toDate:=$3

$openingBalancePtr:=$4
$transferInPtr:=$5
$transferOutPtr:=$6

$sumDebitPtr:=$7
$sumCreditPtr:=$8
$balancePtr:=$9

$sumDebitLocalPtr:=$10
$sumCreditLocalPtr:=$11

If (Count parameters:C259>=12)
	$branchID:=$12
Else 
	$branchID:=""
End if 

// 1ST : load all the registers for this sub account
//selectRegistersByAccountNBranch ($accountID;$branchID)
QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$accountID)
QUERY SELECTION:C341([Registers:10]; [Registers:10]SubAccountID:58="")
QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)
If ($branchID#"")
	QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=$branchID)
End if 
// 2ND : constrain the ending period - period [0 to B]
QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2<=$toDate)

// 3RD: calculate the sum from beginning to end (this is the ending balance)
$balancePtr->:=Sum:C1([Registers:10]Debit:8)-Sum:C1([Registers:10]Credit:7)
$balanceLocal:=Sum:C1([Registers:10]DebitLocal:23)-Sum:C1([Registers:10]CreditLocal:24)

// 4TH: constrain the starting period (this is the period sum) - [A to B]
QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$fromDate)
$sumDebitPtr->:=Sum:C1([Registers:10]Debit:8)
$sumCreditPtr->:=Sum:C1([Registers:10]Credit:7)
$sumDebitLocal:=Sum:C1([Registers:10]DebitLocal:23)
$sumCreditLocal:=Sum:C1([Registers:10]CreditLocal:24)

// 5th: Calculate the difference of total minus the period sum to get the opening balance - [0 to A)
$openingBalancePtr->:=$balancePtr->-($sumDebitPtr->-$sumCreditPtr->)

// filter out the transfers only
QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=True:C214)
$transferInPtr->:=Sum:C1([Registers:10]Debit:8)
$transferOutPtr->:=Sum:C1([Registers:10]Credit:7)

// recalculate the buy/sell by subtracting the transfer amounts
$sumDebitPtr->:=$sumDebitPtr->-$transferInPtr->
$sumCreditPtr->:=$sumCreditPtr->-$transferOutPtr->

$sumDebitLocalPtr->:=$sumDebitLocal
$sumCreditLocalPtr->:=$sumCreditLocal

