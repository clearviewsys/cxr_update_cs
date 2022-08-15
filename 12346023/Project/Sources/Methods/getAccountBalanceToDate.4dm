//%attributes = {}
// getAccountBalanceToDate (accountID;toDate;->openingDebit;->openingCredit;->sumDebit;->sumCredit;->Balance)
C_TEXT:C284($1; $accountID)
C_DATE:C307($2; $toDate)
C_POINTER:C301($openingDebitPtr; $openingCreditPtr; $sumDebitPtr; $sumCreditPtr; $balancePtr; $3; $4; $5; $6; $7)
$accountID:=$1
$toDate:=$2
$openingDebitPtr:=$3
$openingCreditPtr:=$4
$sumDebitPtr:=$5
$sumCreditPtr:=$6
$balancePtr:=$7

READ ONLY:C145([Registers:10])
READ ONLY:C145([Accounts:9])

COPY NAMED SELECTION:C331([Registers:10]; "registerSort")
// 1 select all the registers for the accountID
QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$accountID; *)
// 2 : constrain the ending period
QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<$toDate)

sumSelectionOn2Fields(->[Registers:10]; ->[Registers:10]Debit:8; ->[Registers:10]Credit:7; $sumDebitPtr; $sumCreditPtr)  // needs optimization (slow for loop)

$balancePtr->:=$sumDebitPtr->-$sumCreditPtr->

USE NAMED SELECTION:C332("registerSort")
CLEAR NAMED SELECTION:C333("registerSort")