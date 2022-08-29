//%attributes = {}
// PL_fillCurrencySummaryListBox (fromDate;toDate;BranchID)
// This one has an error with balances

C_LONGINT:C283($n; $i; $m)
C_DATE:C307($fromDate; $toDate; $1; $2)
C_TEXT:C284($branchID; $3)

C_REAL:C285($Buy; $Sell; $avgBuyRate; $ShortRate; $Inventory; $revenueLC; $costLC; $COGS; $profit; $net)  // line variables
C_REAL:C285($sumBuy; $sumSell; $sumRevenueLC; $sumCostLC; $sumFeesLC; $sumCOGS; $sumProfits; $sumNetProfits; $openingInventory)  // sum variables
C_REAL:C285($temp; $runningInventory; $runningAvgBuy; $runningShortRate)
C_LONGINT:C283($progress)
C_TEXT:C284($curr)

Case of 
	: (Count parameters:C259=0)
		$fromDate:=!00-00-00!
		$toDate:=Current date:C33
		$branchID:=""
		
	: (Count parameters:C259=3)
		$fromDate:=$1
		$toDate:=$2
		$branchID:=$3
	Else 
		ASSERT:C1129(False:C215; "invalid number of params")
End case 

ALL RECORDS:C47([Currencies:6])
DISTINCT VALUES:C339([Currencies:6]ISO4217:31; arrCurrencies)
SORT ARRAY:C229(arrCurrencies)  // sort by currency code
$n:=Size of array:C274(arrCurrencies)

$i:=Find in array:C230(arrCurrencies; <>BASECURRENCY)  // remove the base currency
DELETE FROM ARRAY:C228(arrCurrencies; $i)
INSERT IN ARRAY:C227(arrCurrencies; 1; 1)

PL_initListBoxSummaryArrays($n)  // resize all summary arrays to $n

//LISTBOX INSERT ROWS(*;"PL_SummaryListBox";1;1) // INSERT A ROW FOR BASE CURRENCY to appear on top of the list

//___________________________________________________
// the first row is the Base Currency
PL_queryRegistersLessThanDate(<>BASECURRENCY; $branchID; $fromDate)  // queries all relevant registers up to fromDate (not inclusive)
arrOpenings{1}:=Sum:C1([Registers:10]Debit:8)-Sum:C1([Registers:10]Credit:7)

PL_queryRegistersInDateRange(<>baseCurrency; $branchID; $fromDate; $toDate)
arrCurrencies{1}:=<>BASECURRENCY
arrBuys{1}:=Sum:C1([Registers:10]Debit:8)
arrSells{1}:=Sum:C1([Registers:10]Credit:7)
ArrBalances{1}:=arrOpenings{1}+arrBuys{1}-arrSells{1}
arrBuyRates{1}:=1
arrTotalFees{1}:=Sum:C1([Registers:10]totalFees:30)
arrNetProfits{1}:=arrTotalFees{1}

//___________________________________________________
// the 2nd row onward are the rest of the currencies

$progress:=launchProgressBar("Calculating...")
$i:=2

Repeat 
	$runningInventory:=0
	$runningAvgBuy:=0
	$runningShortRate:=0
	$avgBuyRate:=0
	$ShortRate:=0
	$Inventory:=0
	
	$curr:=arrCurrencies{$i}
	setProgressBarTitle($progress; $curr)
	
	//If ($fromDate#!00/00/0000!)
	//$m:=PL_queryRegistersLessThanDate ($curr;$branchID;$fromDate)  // queries all relevant registers up to fromDate (not inclusive)
	//If ($m>0)
	//SELECTION TO ARRAY([Registers]Debit;$arrBuys;[Registers]Credit;$arrSells;[Registers]OurRate;$arrRates)
	//PL_calcSummaryVars_onArrays (0;0;0;->$arrBuys;->$arrSells;->$arrRates;->$avgbuyRate;->$shortRate;->$inventory;->$sumCOGS;->$sumProfits)
	//  //PL_calcSummaryVars_Registers ($runningInventory;$runningAvgBuy;$runningShortRate;->$avgbuyRate;->$shortRate;->$inventory;->$sumBuy;->$sumSell;->$sumCostLC;->$sumRevenueLC;->$sumFeesLC;->$sumProfits;->$sumCOGs;->$sumNetProfits)
	//
	//$openingInventory:=$inventory  // keep the opening inventory 
	//$runningInventory:=$inventory
	//$runningAvgBuy:=$avgBuyRate
	//$runningShortRate:=$shortRate
	//Else 
	//$openingInventory:=0
	//$runningInventory:=0
	//$runningAvgBuy:=0
	//$runningShortRate:=0
	//End if 
	//
	//End if 
	
	PL_calcSummaryVars_OnServer($curr; $branchID; !00-00-00!; $fromDate; 0; 0; 0; ->$avgBuyRate; ->$ShortRate; ->$Inventory; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp)
	$openingInventory:=$inventory  // keep the opening inventory 
	
	$runningInventory:=$inventory  // the running inventory will change in the next call 
	$runningAvgBuy:=$avgBuyRate
	$runningShortRate:=$shortRate
	
	//$m:=PL_queryRegistersInDateRange ($curr;$branchID;$fromDate;$toDate)  // queries all relevant registers in date range
	//  //PL_calcSummaryVars_Registers ($runningInventory;$runningAvgBuy;$runningShortRate;->$avgbuyRate;->$shortRate;->$inventory;->$sumBuy;->$sumSell;->$sumCostLC;->$sumRevenueLC;->$sumFeesLC;->$sumProfits;->$sumCOGs;->$sumNetProfits)
	//If ($m>0)
	//SELECTION TO ARRAY([Registers]Debit;$arrBuys;[Registers]Credit;$arrSells;[Registers]OurRate;$arrRates)
	//PL_calcSummaryVars_onArrays ($runningInventory;$runningAvgBuy;$runningShortRate;->$arrBuys;->$arrSells;->$arrRates;->$avgbuyRate;->$shortRate;->$inventory;->$sumCOGS;->$sumProfits)
	//PL_calcSummaryVars_Registers ($runningInventory;$runningAvgBuy;$runningShortRate;->$avgbuyRate;->$shortRate;->$inventory;->$sumBuy;->$sumSell;->$sumCostLC;->$sumRevenueLC;->$sumFeesLC;->$sumProfits;->$sumCOGs;->$sumNetProfits)
	//
	//
	//$sumBuy:=Sum($arrBuys)
	//$sumSell:=Sum($arrSells)
	//$sumFeesLC:=Sum([Registers]totalFees)
	//$sumCostLC:=Sum([Registers]DebitLocal)
	//$sumRevenueLC:=Sum([Registers]CreditLocal)
	//$sumNetProfits:=$sumProfits+$sumFeesLC
	//Else 
	//$sumBuy:=0
	//$sumSell:=0
	//$sumFeesLC:=0
	//$sumCostLC:=0
	//$sumRevenueLC:=0
	//$avgBuyRate:=0
	//$ShortRate:=0
	//$Inventory:=0
	//$sumCOGS:=0
	//$sumProfits:=0
	//$sumNetProfits:=0
	//End if 
	PL_calcSummaryVars_OnServer($curr; $branchID; $fromDate; $toDate; $openingInventory; $runningAvgBuy; $runningShortRate; ->$avgBuyRate; ->$ShortRate; ->$Inventory; ->$sumBuy; ->$sumSell; ->$sumCostLC; ->$sumRevenueLC; ->$sumFeesLC; ->$sumProfits; ->$sumCOGS; ->$sumNetProfits)
	
	arrOpenings{$i}:=$openingInventory
	arrBuys{$i}:=$sumBuy
	arrSells{$i}:=$sumSell
	ArrBalances{$i}:=$inventory
	arrBuyRates{$i}:=$avgbuyRate
	arrSellRates{$i}:=$shortRate
	arrInventoryCosts{$i}:=$sumCostLC
	arrRevenues{$i}:=$sumrevenueLC
	arrSumCOGS{$i}:=$sumCOGS
	arrTotalProfits{$i}:=$sumProfits
	arrTotalFees{$i}:=$sumFeesLC
	arrNetProfits{$i}:=$sumNetProfits
	
	refreshProgressBar($progress; $i; $n)
	$i:=$i+1
Until (($i>$n) | (isProgressBarStopped($progress)))

//CLEAR VARIABLE($arrBuys)
//CLEAR VARIABLE($arrSells)
//CLEAR VARIABLE($arrRates)

