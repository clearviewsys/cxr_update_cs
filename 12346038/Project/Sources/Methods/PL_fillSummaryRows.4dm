//%attributes = {}
// PL_fillSummaryRows (fromDate;toDate;BranchID)
// getBuild

C_LONGINT:C283($n; $i; $m)
C_DATE:C307($fromDate; $toDate; $preFromDate; $1; $2)
C_TEXT:C284($branchID; $3)
C_BOOLEAN:C305($showInverseRates; $4)

C_REAL:C285($Buy; $Sell; $avgBuyRate; $ShortRate; $Inventory; $revenueLC; $costLC; $COGS; $profit; $net; $runningAvgBuy; $runningInventory; $runningShortRate; $openingInventory)  // line variables
C_REAL:C285($sumBuy; $sumSell; $sumRevenueLC; $sumCostLC; $sumFeesLC; $sumCOGS; $sumProfits; $sumNetProfits; $openingInventory)  // sum variables
C_REAL:C285($temp)
C_LONGINT:C283($progress)
C_TEXT:C284($curr)

If (isUserAllowedToViewProfits)
	Case of 
		: (Count parameters:C259=0)
			$fromDate:=!00-00-00!
			$toDate:=Current date:C33
			$branchID:=""
			$showInverseRates:=False:C215
		: (Count parameters:C259=3)
			$fromDate:=$1
			$toDate:=$2
			$branchID:=$3
			$showInverseRates:=False:C215
		: (Count parameters:C259=4)
			$fromDate:=$1
			$toDate:=$2
			$branchID:=$3
			$showInverseRates:=$4
		Else 
			ASSERT:C1129(False:C215; "invalid number of params")
	End case 
	$preFromDate:=Add to date:C393($fromDate; 0; 0; -1)  // fromDate Minus one day
	
	$progress:=launchProgressBar("Calculating...")
	READ ONLY:C145([Currencies:6])
	ALL RECORDS:C47([Currencies:6])
	DISTINCT VALUES:C339([Currencies:6]ISO4217:31; arrCurrencies)
	SORT ARRAY:C229(arrCurrencies)  // sort by currency code
	$n:=Size of array:C274(arrCurrencies)
	
	$i:=Find in array:C230(arrCurrencies; <>BASECURRENCY)  // remove the base currency
	DELETE FROM ARRAY:C228(arrCurrencies; $i)
	INSERT IN ARRAY:C227(arrCurrencies; 1; 1)
	arrCurrencies{1}:=<>BASECURRENCY  // 
	
	PL_initListBoxSummaryArrays($n)  // resize all summary arrays to $n
	//LISTBOX INSERT ROWS(*;"PL_SummaryListBox";1;1) // INSERT A ROW FOR BASE CURRENCY to appear on top of the list
	//___________________________________________________
	// the first row is the Base Currency
	
	PL_calcSummaryVars_OnServer(<>BASECURRENCY; $branchID; !00-00-00!; $preFromDate; $runningInventory; $avgBuyRate; $runningShortRate; ->$avgBuyRate; ->$ShortRate; ->$runningInventory; ->$sumBuy; ->$sumSell; ->$sumCostLC; ->$sumRevenueLC; ->$sumFeesLC; ->$sumProfits; ->$sumCOGS; ->$sumNetProfits)
	
	arrOpenings{1}:=$runningInventory
	PL_calcSummaryVars_OnServer(<>BASECURRENCY; $branchID; $fromDate; $toDate; $runningInventory; $avgBuyRate; $runningShortRate; ->$avgBuyRate; ->$ShortRate; ->$runningInventory; ->$sumBuy; ->$sumSell; ->$sumCostLC; ->$sumRevenueLC; ->$sumFeesLC; ->$sumProfits; ->$sumCOGS; ->$sumNetProfits)
	
	arrBuys{1}:=$sumBuy
	arrSells{1}:=$sumSell
	arrBalances{1}:=$runningInventory
	arrBuyRates{1}:=1
	arrTotalFees{1}:=$sumFeesLC
	arrNetProfits{1}:=$sumNetProfits
	
	//___________________________________________________
	// the 2nd row onward are the rest of the currencies         
	$i:=2
	Repeat 
		
		$runningAvgBuy:=0
		$runningShortRate:=0
		$avgBuyRate:=0
		$ShortRate:=0
		
		$curr:=arrCurrencies{$i}
		setProgressBarTitle($progress; $curr)
		
		// there are two called to PL_Calc. first one is from 00/00/00 to date; second one is from fromDate to end date
		
		PL_calcSummaryVars_OnServer($curr; $branchID; !00-00-00!; $preFromDate; 0; 0; 0; ->$avgBuyRate; ->$ShortRate; ->$Inventory; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp)
		$openingInventory:=$inventory  // keep the opening inventory 
		$runningInventory:=$inventory  // the running inventory will change in the next call 
		$runningAvgBuy:=$avgBuyRate
		$runningShortRate:=$shortRate
		
		PL_calcSummaryVars_OnServer($curr; $branchID; $fromDate; $toDate; $openingInventory; $runningAvgBuy; $runningShortRate; ->$avgBuyRate; ->$ShortRate; ->$Inventory; ->$sumBuy; ->$sumSell; ->$sumCostLC; ->$sumRevenueLC; ->$sumFeesLC; ->$sumProfits; ->$sumCOGS; ->$sumNetProfits)
		
		arrOpenings{$i}:=$openingInventory
		arrBuys{$i}:=$sumBuy
		arrSells{$i}:=$sumSell
		arrBalances{$i}:=$inventory
		If ($showInverseRates)
			arrBuyRates{$i}:=calcInverse($avgbuyRate-$ShortRate)
		Else   // default is direct rates
			arrBuyRates{$i}:=$avgbuyRate-$ShortRate
		End if 
		//arrSellRates{$i}:=$shortRate
		arrInventoryCosts{$i}:=$sumCostLC
		arrRevenues{$i}:=$sumrevenueLC
		arrInventoryValueLC{$i}:=$inventory*$avgBuyRate  // #New 
		
		//arrSumCOGS{$i}:=$sumCOGS
		arrSumCOGS{$i}:=$sumRevenueLC-$sumProfits  // this is based on the formula (Revenue - COGS = Profit)
		
		arrTotalProfits{$i}:=$sumProfits
		arrTotalFees{$i}:=$sumFeesLC
		arrNetProfits{$i}:=$sumNetProfits
		
		refreshProgressBar($progress; $i; $n)
		$i:=$i+1
	Until (($i>$n) | (isProgressBarStopped($progress)))
	
	//CLEAR VARIABLE($arrBuys)
	//CLEAR VARIABLE($arrSells)
	//CLEAR VARIABLE($arrRates)
Else 
	myAlert("Access denied!")
End if 
