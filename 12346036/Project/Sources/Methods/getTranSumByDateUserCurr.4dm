//%attributes = {}
// getTranSumByDateUserCurr (date;user;curr;isCancelled;->numBuy;->sumDebit;->sumDebitLC;->numSell;->SumCredit;->sumCreditLC;->sumFee)

// ----------------------------------------------------
// User name (OS): Tiran Behrouz
// Date and time: 12/20/15, 02:57:22
// ----------------------------------------------------
// Method: getTranSumByDateUserCurr
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($branchID; $1)
C_DATE:C307($date; $2)
C_TEXT:C284($user; $3)
C_TEXT:C284($curr; $4)
C_BOOLEAN:C305($isCancelled; $5)
C_POINTER:C301($countDebitPtr; $6)
C_POINTER:C301($sumDebitPtr; $7)
C_POINTER:C301($sumDebitLCPtr; $8)
C_POINTER:C301($countCreditPtr; $9)
C_POINTER:C301($sumCreditPtr; $10)
C_POINTER:C301($sumCreditLCPtr; $11)
C_POINTER:C301($sumFeesPtr; $12)

Case of 
	: (Count parameters:C259=12)
		$branchID:=$1
		$date:=$2
		$user:=$3
		$curr:=$4
		$isCancelled:=$5
		$countDebitPtr:=$6
		$sumDebitPtr:=$7
		$sumDebitLCPtr:=$8
		
		$countCreditPtr:=$9
		$sumCreditPtr:=$10
		$sumCreditLCPtr:=$11
		
		$sumFeesPtr:=$12
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

CREATE SET:C116([Registers:10]; "$tempRegisters")

// do a compound search
If ($branchID="")
	QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2=$date)
Else 
	// search on compounded index
	QUERY:C277([Registers:10]; [Registers:10]BranchID:39=$branchID; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2=$date)
End if 
// sequential search
QUERY SELECTION:C341([Registers:10]; [Registers:10]CreatedByUserID:16=$user)
QUERY SELECTION:C341([Registers:10]; [Registers:10]Currency:19=$curr)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=$isCancelled)

$sumDebitPtr->:=Sum:C1([Registers:10]Debit:8)
$sumDebitLCPtr->:=Sum:C1([Registers:10]DebitLocal:23)
$sumCreditPtr->:=Sum:C1([Registers:10]Credit:7)
$sumCreditLCPtr->:=Sum:C1([Registers:10]CreditLocal:24)
$sumFeesPtr->:=Sum:C1([Registers:10]totalFees:30)

C_LONGINT:C283($n)
$n:=Records in selection:C76([Registers:10])  // total number of registers

QUERY SELECTION:C341([Registers:10]; [Registers:10]Debit:8>0)  // total number of buys only
$countDebitPtr->:=Records in selection:C76([Registers:10])
$countCreditPtr->:=$n-$countDebitPtr->  // deduct the total number of registers from total buys to get total sell

USE SET:C118("$tempRegisters")
CLEAR SET:C117("$tempRegisters")



