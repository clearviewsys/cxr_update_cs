//%attributes = {"executedOnServer":true}
// getaccountbalanceInDateRange (accountID; fromDate ; toDate ;boolApplyDate; ->openingBalance;->transferIn;->transferOut; ->sumDebit;->sumCredit; ->balance)
// This method should run on the Server side. So make sure 'Execute on Server' is on
// This method is at least 3 times faster when executed on the server side

C_TEXT:C284($accountID; $1)
C_DATE:C307($fromDate; $toDate; $2; $3)
C_BOOLEAN:C305($applyDateRange; $4)
C_POINTER:C301($openingBalancePtr; $transferInPtr; $transferOutPtr; $sumDebitPtr; $sumCreditPtr; $balancePtr; $5; $6; $7; $8; $9; $10)
C_POINTER:C301($sumCreditLocalPtr; $sumDebitLocalPtr; $sumFeesPtr; $unrealizedGainPtr; $11; $12; $13; $14)
C_TEXT:C284($branchID; $15)

C_REAL:C285($balanceLocal; $sumCreditLocal; $sumDebitLocal; $sumFees; $sumUnrealizedGain)



$accountID:=$1
$fromDate:=$2
$toDate:=$3
$applyDateRange:=$4

$openingBalancePtr:=$5
$transferInPtr:=$6
$transferOutPtr:=$7

$sumDebitPtr:=$8
$sumCreditPtr:=$9
$balancePtr:=$10

If (Count parameters:C259>=12)
	$sumDebitLocalPtr:=$11
	$sumCreditLocalPtr:=$12
End if 

If (Count parameters:C259>=13)
	$sumFeesPtr:=$13
End if 

If (Count parameters:C259>=14)
	$unrealizedGainPtr:=$14
End if 

If (Count parameters:C259>=15)
	$branchID:=$15
Else 
	$branchID:=""
End if 

C_OBJECT:C1216($summary)
$summary:=New object:C1471
getAccountBalanceInDateRgORDA($accountID; $fromDate; $toDate; $applyDateRange; $branchID; $summary)


$sumFees:=$summary.sumFees
$sumUnrealizedGain:=$summary.sumGains
$balanceLocal:=$summary.balanceLC

$openingBalancePtr->:=$summary.openingBalance
$transferInPtr->:=$summary.transferIn
$transferOutPtr->:=$summary.transferOut
$sumDebitPtr->:=$summary.sumBuys
$sumCreditPtr->:=$summary.sumSells
$balancePtr->:=$summary.balance

If (Count parameters:C259>=12)
	$sumDebitLocalPtr->:=$summary.sumDebitLC
	$sumCreditLocalPtr->:=$summary.sumCreditLC
End if 

If (Count parameters:C259>=13)
	$sumFeesPtr->:=$summary.sumFees
End if 

If (Count parameters:C259>=14)
	$unrealizedGainPtr->:=$summary.sumGains
End if 
