//%attributes = {}
C_LONGINT:C283(cbApplyDateRange)
C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283($i; $n)

// init the listbox itself
ARRAY BOOLEAN:C223(holdingsListBox; 0)

// Init the listbox arrays first
ARRAY PICTURE:C279(arrFlags; 0)
ARRAY TEXT:C222(arrCodes; 0)
ARRAY REAL:C219(arrOpenings; 0)
ARRAY REAL:C219(arrIns; 0)
ARRAY REAL:C219(arrOuts; 0)
ARRAY REAL:C219(arrBalances; 0)
ARRAY REAL:C219(arrBuyRates; 0)
ARRAY REAL:C219(arrSellRates; 0)
ARRAY REAL:C219(arrBERates; 0)
ARRAY REAL:C219(arrFees; 0)
ARRAY REAL:C219(arrInventoryCosts; 0)
ARRAY REAL:C219(arrNetSales; 0)
ARRAY REAL:C219(arrCOGS; 0)
ARRAY REAL:C219(arrNetProfits; 0)
ARRAY LONGINT:C221(arrColour; 0)  // added this line for declaration


// Init the row variables 
C_REAL:C285(vSumInventory; vSumInventoryShort; vVolumeBoughtCAD; vVolumeSoldCAD; vSumCOGS; vSumNetProfits; vSumFees; vSumSalesProfits; vAvgBuy; vAvgSell)

// init the sum variables
C_REAL:C285(vTotalInventoryCost; vInventoryCostCAD)
C_REAL:C285(vTotalInventoryCostShort; vInventoryCostShortCAD)
C_REAL:C285(vTotalNetSales)
C_REAL:C285(vTotalCOGS)
C_REAL:C285(vGrossProfit)
C_REAL:C285(vTotalFeesReceived)
C_REAL:C285(vTotalNetProfit)
C_REAL:C285(vTotalLeverage)  // difference between positive postion and negative position (how much leverage the company has to cover its short inventory)

If (cbApplyDateRange=1)
	selectDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; vFromDate; vToDate)
Else 
	ALL RECORDS:C47([Registers:10])  // 
End if 
RELATE ONE SELECTION:C349([Registers:10]; [Currencies:6])

$n:=Records in selection:C76([Currencies:6])

ARRAY BOOLEAN:C223(holdingsListBox; $n)
// resize all the arrays
LISTBOX INSERT ROWS:C913(holdingsListBox; 1; $n)
ARRAY LONGINT:C221(arrColour; $n)  // resize to match the rest of the arrays
orderByCurrencies


//$formName:="profitVars"  ` What is this doing here? TB Apr, 21, 2008

vSumInventory:=0
vSumInventoryShort:=0
vVolumeBoughtCAD:=0
vVolumeSoldCAD:=0
vSumCOGS:=0
vSumNetProfits:=0
vSumFees:=0
vSumSalesProfits:=0
vAvgBuy:=0
vAvgSell:=0

vTotalInventoryCost:=0
vInventoryCostShortCAD:=0
vTotalInventoryCostShort:=0

vTotalNetSales:=0
vTotalCOGS:=0
vTotalFeesReceived:=0
vGrossProfit:=0
vTotalNetProfit:=0

READ ONLY:C145([Currencies:6])
C_LONGINT:C283($n; $progress)
$n:=Records in selection:C76([Currencies:6])

//_______

C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n)
C_POINTER:C301($tablePtr)
$tablePtr:=->[Currencies:6]

$progress:=launchProgressBar("Currencies Holdings/Profit/Loss Calculation")
$n:=Records in selection:C76($tablePtr->)
$i:=1

FIRST RECORD:C50($tablePtr->)
If ($n>0)
	Repeat 
		LOAD RECORD:C52($tablePtr->)
		refreshProgressBar($progress; $i; $n)
		setProgressBarTitle($progress; "Calculating row :"+[Currencies:6]ISO4217:31)
		
		//calcCurrencyProfitVars (vFromDate;vToDate;(cbApplyDateRange=1))
		calcProfitForCurrencyToDate([Currencies:6]ISO4217:31; vToDate; ->vSumIns; ->vSumOuts; ->vBalance; ->vVolumeBoughtCAD; ->vVolumeSoldCAD; ->vSumFees; ->vAvgBuy; ->vAvgSell; ->vBEAvg; ->vCOGS; ->vInventoryCostCAD; ->vInventoryCostShortCAD)
		
		arrFlags{$i}:=[Currencies:6]Flag:3
		arrCodes{$i}:=[Currencies:6]ISO4217:31
		arrOpenings{$i}:=0
		arrIns{$i}:=vSumIns
		arrOuts{$i}:=vSumOuts
		arrBalances{$i}:=vBalance
		arrBuyRates{$i}:=vAvgBuy
		arrSellRates{$i}:=vAvgSell
		arrBERates{$i}:=vBEAvg
		arrFees{$i}:=vSumFees
		arrInventoryCosts{$i}:=vInventoryCostCAD-vInventoryCostShortCAD  // only one of these has a value; the other is zero
		arrNetSales{$i}:=vVolumeSoldCAD
		arrCOGS{$i}:=vCOGS
		arrNetProfits{$i}:=arrNetSales{$i}-arrCOGS{$i}+arrFees{$i}
		
		If (vBalance<0)
			arrColour{$i}:=0x00FF0000
		Else 
			arrColour{$i}:=0xFF000000
		End if 
		
		accumulateReal(->vTotalInventoryCost; arrInventoryCosts{$i})
		accumulateReal(->vTotalInventoryCostShort; vInventoryCostShortCAD)
		
		accumulateReal(->vTotalNetSales; arrNetSales{$i})
		accumulateReal(->vTotalCOGS; arrCOGS{$i})
		accumulateReal(->vTotalFeesReceived; arrFees{$i})
		
		NEXT RECORD:C51($tablePtr->)
		$i:=$i+1
	Until (($i>$n) | (isProgressBarStopped($progress)))
End if 

HIDE PROCESS:C324($progress)

vGrossProfit:=vTotalNetSales-vTotalCOGS
vTotalNetProfit:=vGrossProfit+vTotalFeesReceived
vTotalLeverage:=vTotalInventoryCost-Abs:C99(vTotalInventoryCostShort)

REDRAW WINDOW:C456  //this method is needed for sum variables in the bottom of the page to update
