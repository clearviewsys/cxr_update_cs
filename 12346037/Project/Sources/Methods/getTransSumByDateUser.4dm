//%attributes = {}
// getTransSumByDateUser (date;user;isCancelled;->numBuy;->sumDebitLC;->numSell;->sumCreditLC;->sumFee)

// ----------------------------------------------------
// User name (OS): Tiran Behrouz
// Date and time: 12/20/15, 02:57:22
// ----------------------------------------------------
// Method: getTranSumByDateUser
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($branchID; $1)
C_DATE:C307($date; $2)
C_TEXT:C284($user; $3)
C_BOOLEAN:C305($isCancelled; $4)
C_POINTER:C301($countDebitPtr; $5)
C_POINTER:C301($sumDebitLCPtr; $6)
C_POINTER:C301($countCreditPtr; $7)
C_POINTER:C301($sumCreditLCPtr; $8)
C_POINTER:C301($sumFeesPtr; $9)

$branchID:=$1
$date:=$2
$user:=$3
$isCancelled:=$4
$countDebitPtr:=$5
$sumDebitLCPtr:=$6
$countCreditPtr:=$7
$sumCreditLCPtr:=$8
$sumFeesPtr:=$9

CREATE SET:C116([Registers:10]; "$tempRegisters")
If ($branchID#"")
	// compound search
	QUERY:C277([Registers:10]; [Registers:10]BranchID:39=$branchID; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2=$date)
Else 
	QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2=$date)
End if 

QUERY SELECTION:C341([Registers:10]; [Registers:10]CreatedByUserID:16=$user)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=$isCancelled)

$sumDebitLCPtr->:=Sum:C1([Registers:10]DebitLocal:23)
$sumCreditLCPtr->:=Sum:C1([Registers:10]CreditLocal:24)
$sumFeesPtr->:=Sum:C1([Registers:10]totalFees:30)

C_LONGINT:C283($n)
$n:=Records in selection:C76([Registers:10])  // total number of registers
QUERY SELECTION:C341([Registers:10]; [Registers:10]Debit:8>0)  // total number of buys only
$countDebitPtr->:=Records in selection:C76([Registers:10])
$countCreditPtr->:=$n-$countDebitPtr->  // deduct the total number of registers from total buys to get total sell

USE SET:C118("$tempRegisters")
CLEAR SET:C117("$tempRegisters")


