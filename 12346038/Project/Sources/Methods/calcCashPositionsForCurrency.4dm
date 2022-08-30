//%attributes = {}

C_TEXT:C284($currency; $1)
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8; $9; $10; $11)
C_POINTER:C301($openingPtr; $transferInPtr; $transferOutPtr; $boughtPtr; $soldPtr; $balancePtr; $debitLocalPtr; $creditLocalPtr; $avgBuyPtr; $avgSellPtr)
$currency:=$1
$openingPtr:=$2
$transferInPtr:=$3
$transferOutPtr:=$4
$boughtPtr:=$5
$soldPtr:=$6
$balancePtr:=$7
$debitLocalPtr:=$8
$creditLocalPtr:=$9
$avgBuyPtr:=$10
$avgSellPtr:=$11

// first select all the registers that are cash 
QUERY:C277([Accounts:9]; [Accounts:9]isCashAccount:3=True:C214; *)
QUERY:C277([Accounts:9];  & ; [Accounts:9]Currency:6=$currency)
RELATE MANY SELECTION:C340([Registers:10]AccountID:6)
orderByRegisters

CREATE SET:C116([Registers:10]; "$CashTransactions")

If (cbApplyDateRange=1)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2<vFromDate)
	$openingPtr->:=Sum:C1([Registers:10]Debit:8)-Sum:C1([Registers:10]Credit:7)
	USE SET:C118("$CashTransactions")
	
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
Else 
	$openingPtr->:=0
End if 




// Now limit the end date <=
//QUERY SELECTION([Registers];[Registers]RegisterDate<=vtoDate)
$boughtPtr->:=Sum:C1([Registers:10]Debit:8)
$soldPtr->:=Sum:C1([Registers:10]Credit:7)
$balancePtr->:=$boughtPtr->-$soldPtr->+$openingPtr->
$debitLocalPtr->:=Sum:C1([Registers:10]DebitLocal:23)
$creditLocalPtr->:=Sum:C1([Registers:10]CreditLocal:24)

// filter out the transfers only
QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=True:C214)
$transferInPtr->:=Sum:C1([Registers:10]Debit:8)
$transferOutPtr->:=Sum:C1([Registers:10]Credit:7)

// recalculate the buy/sell
$boughtPtr->:=$boughtPtr->-$transferInPtr->
$soldPtr->:=$soldPtr->-$transferOutPtr->

$avgBuyPtr->:=calcSafeDivide($debitLocalPtr->; $boughtPtr->)
$avgSellPtr->:=calcSafeDivide($creditLocalPtr->; $soldPtr->)

CLEAR SET:C117("$CashTransactions")
