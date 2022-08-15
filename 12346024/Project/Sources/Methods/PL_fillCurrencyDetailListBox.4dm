//%attributes = {}
// fillPLListBoxRows (currency;branch; fromDate;toDate; calcInverseRates)
C_TEXT:C284($curr; $branchID; $1; $2)
C_DATE:C307($fromDate; $toDate; $3; $4)
C_BOOLEAN:C305($doInverseRates; $5)

C_LONGINT:C283($n; $m; $i)
C_REAL:C285($openingProfit; $profit; $avgBuyRate; $shortRate; $inventory; $buy; $sell; $rate; $feesLC; $profitSum; $cogs)
C_REAL:C285($buy; $sell; $buyLC; $sellLC; $rate; $openingBuy; $openingSell; $openingBuyRate; $openingShortRate; $openingDebitLC; $openingCreditLC; $openingCOGS; $openingInventory; $openingFee; $openingNet; $openingRate)

$curr:="USD"
$branchID:=""
$fromDate:=!00-00-00!
$toDate:=Current date:C33
$doInverseRates:=False:C215

Case of 
	: (Count parameters:C259=0)
	: (Count parameters:C259=1)
		$curr:=$1
	: (Count parameters:C259=2)
		$curr:=$1
		$branchID:=$2
		
	: (Count parameters:C259=3)
		$curr:=$1
		$branchID:=$2
		$fromDate:=$3
		
	: (Count parameters:C259=4)
		$curr:=$1
		$branchID:=$2
		$fromDate:=$3
		$toDate:=$4
		
	: (Count parameters:C259=5)
		$curr:=$1
		$branchID:=$2
		$fromDate:=$3
		$toDate:=$4
		$doInverseRates:=$5
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

PL_calcOpeningVars($curr; $branchID; $fromDate; ->$openingInventory; ->$openingBuy; ->$openingSell; ->$inventory; ->$openingBuyRate; ->$openingShortRate; ->$openingDebitLC; ->$openingCreditLC; ->$openingProfit; ->$openingFee; ->$openingCOGS; ->$openingNet)
// Now the query needs to be done from fromDate to toDate (the DATE RANGE inclusive)

$n:=PL_queryRegistersInDateRange($curr; $branchID; $fromDate; $toDate)


$buy:=0
$sell:=0
$profit:=0
$cogs:=0
// IT IS VERY IMPORTANT TO PASS ON THESE VARIABLES TO THE NEXT STAGE OF CALCULATION
$inventory:=$openingInventory
$avgBuyRate:=$openingBuyRate
$shortRate:=$openingShortRate

PL_initListBoxDetailArrays($n)  // initializes the arrays to n rows

// fill the arrays
// getBuild
SELECTION TO ARRAY:C260([Registers:10]RegisterDate:2; ARRDATES; [Registers:10]RegisterID:1; ARRREGISTERIDS; [Registers:10]Debit:8; arrDebits; [Registers:10]Credit:7; arrCredits; [Registers:10]OurRate:25; arrRates; [Registers:10]DebitLocal:23; ARRDEBITLOCALS; [Registers:10]CreditLocal:24; ARRCREDITLOCALS; [Registers:10]totalFees:30; ARRFEES)

//PL_calcDateRangeVars
For ($i; 1; $n)
	$buy:=arrDebits{$i}
	$sell:=arrCredits{$i}
	$rate:=arrRates{$i}
	$buyLC:=ARRDEBITLOCALS{$i}  // revenue LC
	$sellLC:=ARRCREDITLOCALS{$i}  // purchase cost LC
	$feesLC:=ARRFEES{$i}
	
	PL_calcRowByRowVars($buy; $sell; $rate; $buyLC; $sellLC; $feesLC; ->$inventory; ->$avgBuyRate; ->$shortRate; ->$profit)
	
	
	arrAvgBuyRates{$i}:=$avgBuyRate
	arrShortRates{$i}:=$shortRate
	
	arrInventory{$i}:=$inventory
	arrProfits{$i}:=$profit
	arrNets{$i}:=ARRFEES{$i}+arrProfits{$i}
	ARRCOGS{$i}:=ARRCreditLOCALS{$i}-arrProfits{$i}  // (Profit = Revenue - COGS) 
	
	//If ($sell>0)
	//ARRCOGS{$i}:=$sell*$avgBuyRate // this is the original method
	//Else 
	//arrCOGS{$i}:=0
	//End if 
	
End for 


// insert 1 row on top of all the rows to add the opening 
PL_InsertInDetailListBoxArrays

// add the Opening Line to the first line of the ListBox
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

If ($doInverseRates)
	$n:=Size of array:C274(arrAvgBuyRates)
	For ($i; 1; $n)
		arrRates{$i}:=calcInverse(arrRates{$i})
		arrShortRates{$i}:=calcInverse(arrShortRates{$i})
		arrAvgBuyRates{$i}:=calcInverse(arrAvgBuyRates{$i})
	End for 
End if 
// leaves a line of blank between the Opening Line and the rest of the lines
//PL_InsertInDetailListBoxArrays (2;1)