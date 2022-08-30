//%attributes = {}
// fillPLListBoxRows
C_TEXT:C284($curr; $1)
C_DATE:C307($fromDate; $toDate; $2; $3)
C_LONGINT:C283($n; $i)
C_REAL:C285($profit; $avgBuyRate; $shortRate; $inventory; $buy; $sell; $rate; $profitSum; $cogs)
C_REAL:C285($openingBuy; $openingSell; $openingBuyRate; $openingShortRate; $openingDebitLC; $openingCreditLC; $openingCOGS; $openingInventory; $openingFee; $openingNet; $openingRate)
C_LONGINT:C283($openingProfit)

$curr:="USD"
$fromDate:=!00-00-00!
$toDate:=Current date:C33

Case of 
	: (Count parameters:C259=0)
		
	: (Count parameters:C259=1)
		$curr:=$1
		
	: (Count parameters:C259=2)
		$curr:=$1
		$fromDate:=$2
		
	: (Count parameters:C259=3)
		$curr:=$1
		$fromDate:=$2
		$toDate:=$3
		
	Else 
		ASSERT:C1129(False:C215; "invalid number of params")
End case 


READ ONLY:C145([Registers:10])

// search all registers from day 1 upto fromDate (not including that day)
QUERY:C277([Registers:10]; [Registers:10]isTransfer:3=False:C215; *)
QUERY:C277([Registers:10];  & ; [Registers:10]isCancelled:59=False:C215; *)
QUERY:C277([Registers:10];  & ; [Registers:10]Currency:19=$curr; *)
QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<$fromDate)
ORDER BY:C49([Registers:10]; [Registers:10]RegisterDate:2; >; [Registers:10]RegisterID:1; >)


$n:=Records in selection:C76([Registers:10])

$openingBuy:=Sum:C1([Registers:10]Debit:8)
$openingSell:=Sum:C1([Registers:10]Credit:7)
$openingFee:=Sum:C1([Registers:10]feeLocal:29)
$openingDebitLC:=Sum:C1([Registers:10]DebitLocal:23)
$openingCreditLC:=Sum:C1([Registers:10]CreditLocal:24)
$openingInventory:=$openingBuy-$openingSell
$openingRate:=0
$openingBuyRate:=0
$openingShortRate:=0
$openingProfit:=0
$openingCOGS:=0
$openingNet:=0

For ($i; 1; $n)
	GOTO SELECTED RECORD:C245([Registers:10]; $i)  // load the record
	$buy:=[Registers:10]Debit:8
	$sell:=[Registers:10]Credit:7
	$rate:=[Registers:10]OurRate:25
	
	calcPLRow($buy; $sell; $rate; ->$inventory; ->$avgBuyRate; ->$shortRate; ->$profit)
	$openingProfit:=$openingProfit+$profit
	If ($sell>0)
		$cogs:=($sell*$avgBuyRate)
		$openingCOGS:=$openingCOGS+$COGS
	Else 
		$cogs:=0
	End if 
End for 

// Now the query needs to be done from fromDate to toDate (the DATE RANGE specified inclusive)
QUERY:C277([Registers:10]; [Registers:10]isTransfer:3=False:C215; *)
QUERY:C277([Registers:10];  & ; [Registers:10]isCancelled:59=False:C215; *)
QUERY:C277([Registers:10];  & ; [Registers:10]Currency:19=$curr; *)
QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2>=$fromDate; *)
QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
ORDER BY:C49([Registers:10]; [Registers:10]RegisterDate:2; >; [Registers:10]RegisterID:1; >)
$n:=Records in selection:C76([Registers:10])

$buy:=0
$sell:=0
$avgBuyRate:=$avgBuyRate
$shortRate:=$shortRate
$profit:=0
$cogs:=0
$inventory:=$openingInventory

ARRAY TEXT:C222(ARRREGISTERIDS; $n)
ARRAY DATE:C224(ARRDATES; $n)
ARRAY REAL:C219(arrDebits; $n)
ARRAY REAL:C219(arrCredits; $n)
ARRAY REAL:C219(arrRates; $n)
ARRAY REAL:C219(arrInventory; $n)
ARRAY REAL:C219(arrProfits; $n)
ARRAY REAL:C219(arrAvgBuyRates; $n)
ARRAY REAL:C219(arrShortRates; $n)
ARRAY REAL:C219(ARRDEBITLOCALS; $n)
ARRAY REAL:C219(ARRCREDITLOCALS; $n)
ARRAY REAL:C219(ARRFEES; $n)
ARRAY REAL:C219(arrCOGS; $n)
ARRAY REAL:C219(arrNets; $n)


SELECTION TO ARRAY:C260([Registers:10]RegisterDate:2; ARRDATES; [Registers:10]RegisterID:1; ARRREGISTERIDS; [Registers:10]Debit:8; arrDebits; [Registers:10]Credit:7; arrCredits; [Registers:10]OurRate:25; arrRates; [Registers:10]DebitLocal:23; ARRDEBITLOCALS; [Registers:10]CreditLocal:24; ARRCREDITLOCALS; [Registers:10]feeLocal:29; ARRFEES)

For ($i; 1; $n)
	$buy:=arrDebits{$i}
	$sell:=arrCredits{$i}
	$rate:=arrRates{$i}
	
	calcPLRow($buy; $sell; $rate; ->$inventory; ->$avgBuyRate; ->$shortRate; ->$profit)
	arrAvgBuyRates{$i}:=$avgBuyRate
	arrShortRates{$i}:=$shortRate
	arrInventory{$i}:=$inventory
	arrProfits{$i}:=$profit
	arrNets{$i}:=ARRFEES{$i}+arrProfits{$i}
	
	If ($sell>0)
		ARRCOGS{$i}:=$sell*$avgBuyRate
	Else 
		arrCOGS{$i}:=0
	End if 
	
End for 

// insert 1 row on top of all the rows to add the opening 
INSERT IN ARRAY:C227(ARRREGISTERIDS; 1; 1)
INSERT IN ARRAY:C227(ARRDATES; 1; 1)
INSERT IN ARRAY:C227(arrDebits; 1; 1)
INSERT IN ARRAY:C227(arrCredits; 1; 1)
INSERT IN ARRAY:C227(arrRates; 1; 1)
INSERT IN ARRAY:C227(arrInventory; 1; 1)
INSERT IN ARRAY:C227(arrProfits; 1; 1)
INSERT IN ARRAY:C227(arrAvgBuyRates; 1; 1)
INSERT IN ARRAY:C227(arrShortRates; 1; 1)
INSERT IN ARRAY:C227(ARRDEBITLOCALS; 1; 1)
INSERT IN ARRAY:C227(ARRCREDITLOCALS; 1; 1)
INSERT IN ARRAY:C227(ARRFEES; 1; 1)
INSERT IN ARRAY:C227(arrCOGS; 1; 1)
INSERT IN ARRAY:C227(arrNets; 1; 1)

ARRREGISTERIDS{1}:="Opening balance"
arrDates{1}:=$fromDate
arrDebits{1}:=$openingBuy
arrCredits{1}:=$openingSell
arrRates{1}:=$openingRate
arrInventory{1}:=$openingInventory
arrProfits{1}:=$openingProfit
arrAvgBuyRates{1}:=$openingBuyRate
arrShortRates{1}:=$openingShortRate
ARRDEBITLOCALS{1}:=$openingDebitLC
ARRCREDITLOCALS{1}:=$openingCreditLC
ARRFEES{1}:=$openingFee
arrCOGS{1}:=$openingCOGS
arrNets{1}:=$openingProfit+$openingFee


INSERT IN ARRAY:C227(ARRREGISTERIDS; 2; 1)
INSERT IN ARRAY:C227(ARRDATES; 2; 1)
INSERT IN ARRAY:C227(arrDebits; 2; 1)
INSERT IN ARRAY:C227(arrCredits; 2; 1)
INSERT IN ARRAY:C227(arrRates; 2; 1)
INSERT IN ARRAY:C227(arrInventory; 2; 1)
INSERT IN ARRAY:C227(arrProfits; 2; 1)
INSERT IN ARRAY:C227(arrAvgBuyRates; 2; 1)
INSERT IN ARRAY:C227(arrShortRates; 2; 1)
INSERT IN ARRAY:C227(ARRDEBITLOCALS; 2; 1)
INSERT IN ARRAY:C227(ARRCREDITLOCALS; 2; 1)
INSERT IN ARRAY:C227(ARRFEES; 2; 1)
INSERT IN ARRAY:C227(arrCOGS; 2; 1)
INSERT IN ARRAY:C227(arrNets; 2; 1)