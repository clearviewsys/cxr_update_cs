//%attributes = {}
// queryCustomers_CTR (customerID;fromdate; toDate;->buyVolumePtr; ->sellVolumePtr; ->buyCount; ->sellCount;->max; {1: Cash; 2: EFT}): returns the sum of debitLC
// this method queries Registers that are cash only and related to a customer on a specific date
// aggregate customer cash transaction on a specific date

C_TEXT:C284($customerID; $1)
C_DATE:C307($date; $2; $toDate; $3)
C_POINTER:C301($incomingPtr; $outgoingPtr; $sumPtr; $buyCountPtr; $sellCountPtr; $maxPtr; $avgBuyPtr; $avgSellPtr; $4; $5; $6; $7; $8; $9; $10; $11)
C_LONGINT:C283($12; $selector)

Case of 
		
		
	: (Count parameters:C259=11)
		$customerID:=$1
		$date:=$2
		$toDate:=$3
		$incomingPtr:=$4
		$outgoingPtr:=$5
		$sumPtr:=$6
		$maxPtr:=$7
		$buyCountPtr:=$8
		$sellCountPtr:=$9
		$avgBuyPtr:=$10
		$avgSellPtr:=$11
		$selector:=1  // cash
		
	: (Count parameters:C259=12)
		$customerID:=$1
		$date:=$2
		$toDate:=$3
		$incomingPtr:=$4
		$outgoingPtr:=$5
		$sumPtr:=$6
		$maxPtr:=$7
		$buyCountPtr:=$8
		$sellCountPtr:=$9
		$avgBuyPtr:=$10
		$avgSellPtr:=$11
		$selector:=$12  // 1: Cash 2:EFT
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

QUERY:C277([Registers:10]; [Registers:10]CustomerID:5=$customerID)
If ($toDate=$date)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2=$date)  // optimized query
Else 
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$date)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2<=$todate)
End if 

SET FIELD RELATION:C919([Registers:10]AccountID:6; Automatic:K51:4; Manual:K51:3)  // for JOIN

Case of 
	: ($selector=1)  // cash
		QUERY SELECTION BY FORMULA:C207([Registers:10]; [Accounts:9]isCashAccount:3=True:C214)  // JOIN: cash only transactions (dynamic search)
		
	: ($selector=2)  // eft
		QUERY SELECTION BY FORMULA:C207([Registers:10]; [Accounts:9]isEFT:41=True:C214)  // JOIN: cash only transactions (dynamic search)
		
	Else 
End case 

SET FIELD RELATION:C919([Registers:10]AccountID:6; Manual:K51:3; Manual:K51:3)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)
C_REAL:C285($maxDebitLC; $maxCreditLC)

C_LONGINT:C283($totalCount; $buyCount; $sellCount)
C_POINTER:C301($buyCountPtr; $sellCountPtr; $avgBuyPtr; $avgSellPtr)
$sumPtr->:=Sum:C1([Registers:10]DebitLocal:23)+Sum:C1([Registers:10]CreditLocal:24)  // sum of all transaction volume
$totalCount:=Records in selection:C76([Registers:10])
$maxCreditLC:=Max:C3([Registers:10]CreditLocal:24)
$maxDebitLC:=Max:C3([Registers:10]DebitLocal:23)
$maxPtr->:=calcMax($maxCreditLC; $maxDebitLC)

QUERY SELECTION:C341([Registers:10]; [Registers:10]DebitLocal:23>0)  // received cash only 
$buyCount:=Records in selection:C76([Registers:10])  // # of buy

$incomingPtr->:=Sum:C1([Registers:10]DebitLocal:23)  // incoming (buy) volume
$outgoingPtr->:=$sumPtr->-$incomingPtr->  //  outgoing (sell) volume
$sellCount:=$totalCount-$buyCount  // # of sells
$buyCountPtr->:=$buyCount
$sellCountPtr->:=$sellCount

$avgBuyPtr->:=calcSafeDivide($incomingPtr->; $buyCount)
$avgSellPtr->:=calcSafeDivide($outgoingPtr->; $sellCount)


