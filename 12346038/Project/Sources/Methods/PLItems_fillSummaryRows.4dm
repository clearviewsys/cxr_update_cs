//%attributes = {}
// PLItems_fillSummaryRows (fromDate;toDate;BranchID)

C_LONGINT:C283($n; $i)
C_DATE:C307($fromDate; $toDate; $preFromDate; $1; $2)
C_TEXT:C284($branchID; $3)

C_REAL:C285($Buy; $Sell; $avgBuyRate; $ShortRate; $Inventory; $revenueLC; $costLC; $COGS; $profit; $net; $runningAvgBuy; $runningInventory; $runningShortRate; $openingInventory)  // line variables
C_REAL:C285($sumBuy; $sumSell; $sumRevenueLC; $sumCostLC; $sumFeesLC; $sumCOGS; $sumProfits; $sumNetProfits; $openingInventory)  // sum variables
C_REAL:C285($temp)
C_LONGINT:C283($progress)

If (isUserAllowedToViewProfits)
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
	$preFromDate:=Add to date:C393($fromDate; 0; 0; -1)  // fromDate Minus one day
	
	$progress:=launchProgressBar("Calculating...")
	
	ALL RECORDS:C47([ItemInOuts:40])
	DISTINCT VALUES:C339([ItemInOuts:40]ItemID:2; arrItemIDs)
	SORT ARRAY:C229(arrItemIDs)  // sort by currency code
	$n:=Size of array:C274(arrItemIDs)
	
	PL_initListBoxSummaryArrays($n)  // resize all summary arrays to $n   
	ARRAY TEXT:C222(arrItemIDs; $n)
	ARRAY REAL:C219(arrSummaryShortRates; $n)
	ARRAY REAL:C219(arrSummaryTax1; $n)
	ARRAY REAL:C219(arrSummaryTax2; $n)
	C_REAL:C285($sumTax1; $sumTax2)
	$i:=1
	C_TEXT:C284($itemID)
	Repeat 
		
		$runningAvgBuy:=0
		$runningShortRate:=0
		$avgBuyRate:=0
		$ShortRate:=0
		$sumTax1:=0
		$sumTax2:=0
		$itemID:=arrItemIDs{$i}
		setProgressBarTitle($progress; $itemID)
		PLItems_calcSummaryVars_server($itemID; $branchID; !00-00-00!; $preFromDate; 0; 0; 0; ->$avgBuyRate; ->$ShortRate; ->$Inventory; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp; ->$temp)
		$openingInventory:=$inventory  // keep the opening inventory 
		$runningInventory:=$inventory  // the running inventory will change in the next call 
		$runningAvgBuy:=$avgBuyRate
		$runningShortRate:=$shortRate
		
		PLItems_calcSummaryVars_server($itemID; $branchID; $fromDate; $toDate; $openingInventory; $runningAvgBuy; $runningShortRate; ->$avgBuyRate; ->$ShortRate; ->$Inventory; ->$sumBuy; ->$sumSell; ->$sumCostLC; ->$sumRevenueLC; ->$sumFeesLC; ->$sumProfits; ->$sumCOGS; ->$sumNetProfits; ->$sumTax1; ->$sumTax2)
		
		arrOpenings{$i}:=$openingInventory
		arrBuys{$i}:=$sumBuy
		arrSells{$i}:=$sumSell
		ArrBalances{$i}:=$inventory
		
		//arrBuyRates{$i}:=$avgbuyRate-$ShortRate
		arrBuyRates{$i}:=$avgbuyRate
		arrInventoryCosts{$i}:=$sumCostLC
		arrRevenues{$i}:=$sumrevenueLC
		
		arrTotalProfits{$i}:=$sumProfits
		arrTotalFees{$i}:=$sumFeesLC
		arrNetProfits{$i}:=$sumNetProfits
		
		//arrSumCOGS{$i}:=$sumCOGS
		arrSumCOGS{$i}:=arrRevenues{$i}-arrNetProfits{$i}
		
		arrSummaryShortRates{$i}:=$ShortRate
		arrSummaryTax1{$i}:=$sumTax1
		arrSummaryTax2{$i}:=$sumTax2
		refreshProgressBar($progress; $i; $n)
		$i:=$i+1
	Until (($i>$n) | (isProgressBarStopped($progress)))
	
Else 
	myAlert("Access denied!")
End if 
