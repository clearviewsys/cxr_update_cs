//%attributes = {}
// fillPLListBoxRows (itemID;branch; fromDate;toDate)
C_TEXT:C284($itemID; $branchID; $1; $2)
C_DATE:C307($fromDate; $toDate; $3; $4)
C_LONGINT:C283($n; $i)
C_REAL:C285($profit; $avgBuyRate; $shortRate; $inventory; $buy; $sell; $feeLC; $rate; $buyLC; $sellLC; $profitSum; $cogs)
C_REAL:C285($openingBuy; $openingSell; $openingBuyRate; $openingShortRate; $openingDebitLC; $openingCreditLC; $openingCOGS; $openingInventory; $openingFee; $openingNet; $openingRate)
C_REAL:C285($openingProfit)

$branchID:=""
$fromDate:=!00-00-00!
$toDate:=Current date:C33

Case of 
	: (Count parameters:C259=1)
		$itemID:=$1
	: (Count parameters:C259=2)
		$itemID:=$1
		$branchID:=$2
	: (Count parameters:C259=3)
		$itemID:=$1
		$branchID:=$2
		$fromDate:=$3
	: (Count parameters:C259=4)
		$itemID:=$1
		$branchID:=$2
		$fromDate:=$3
		$toDate:=$4
	Else 
		ASSERT:C1129(False:C215; "invalid number of params")
End case 

PLItems_calcOpeningVars($itemID; $branchID; $fromDate; ->$openingInventory; ->$openingBuy; ->$openingSell; ->$inventory; ->$openingBuyRate; ->$openingShortRate; ->$openingDebitLC; ->$openingCreditLC; ->$openingProfit; ->$openingFee; ->$openingCOGS; ->$openingNet)
// Now the query needs to be done from fromDate to toDate (the DATE RANGE inclusive)

$buy:=0
$sell:=0
$profit:=0
$cogs:=0
// IT IS VERY IMPORTANT TO PASS ON THESE VARIABLES TO THE NEXT STAGE OF CALCULATION
$inventory:=$openingInventory
$avgBuyRate:=$openingBuyRate
$shortRate:=$openingShortRate
ALL RECORDS:C47([ItemInOuts:40])
$n:=PL_queryItemsIOInDateRange($itemID; $branchID; $fromDate; $toDate)
PL_initListBoxDetailArrays($n)  // initializes the arrays to n rows
ARRAY TEXT:C222(arrItemInOutIds; $n)
ARRAY REAL:C219(arrTax1; $n)
ARRAY REAL:C219(arrTax2; $n)

FIRST RECORD:C50([ItemInOuts:40])
For ($i; 1; $n)
	arrDates{$i}:=[ItemInOuts:40]Date:3
	arrItemInOutIds{$i}:=[ItemInOuts:40]ItemInOutID:1
	ARRFEES{$i}:=[ItemInOuts:40]FeeLocal:19
	arrTax1{$i}:=[ItemInOuts:40]tax1:20
	arrTax2{$i}:=[ItemInOuts:40]tax2:21
	$rate:=[ItemInOuts:40]UnitPrice:9
	arrRates{$i}:=$rate
	If ([ItemInOuts:40]isSold:7=True:C214)
		$sell:=[ItemInOuts:40]Qty:8
		arrCredits{$i}:=[ItemInOuts:40]Qty:8
		ARRCREDITLOCALS{$i}:=[ItemInOuts:40]Amount:22
		$buy:=0
		arrDebits{$i}:=0
		ARRDEBITLOCALS{$i}:=0
		$buyLC:=0
		$sellLC:=[ItemInOuts:40]Amount:22
	Else 
		//use negative sign for tax when buying items
		arrTax1{$i}:=-arrTax1{$i}
		arrTax2{$i}:=-arrTax2{$i}
		$buy:=[ItemInOuts:40]Qty:8
		arrDebits{$i}:=[ItemInOuts:40]Qty:8
		ARRDEBITLOCALS{$i}:=[ItemInOuts:40]Amount:22
		$sell:=0
		arrCredits{$i}:=0
		ARRCREDITLOCALS{$i}:=0
		$sellLC:=0
		$buyLC:=[ItemInOuts:40]Amount:22
	End if 
	$feeLC:=[ItemInOuts:40]FeeLocal:19
	
	PL_calcRowByRowVars($buy; $sell; $rate; $buyLC; $sellLC; $feeLC; ->$inventory; ->$avgBuyRate; ->$shortRate; ->$profit)
	arrAvgBuyRates{$i}:=$avgBuyRate
	arrShortRates{$i}:=$shortRate
	arrInventory{$i}:=$inventory
	arrProfits{$i}:=$profit
	arrNets{$i}:=ARRFEES{$i}+arrProfits{$i}
	//If ($sell>0)
	//arrCOGS{$i}:=$sell*$avgBuyRate
	//Else 
	//arrCOGS{$i}:=0
	//End if 
	arrCOGS{$i}:=ARRCREDITLOCALS{$i}-arrNets{$i}
	NEXT RECORD:C51([ItemInOuts:40])
End for 

// insert 1 row on top of all the rows to add the opening 
PL_InsertInDetailListBoxArrays
INSERT IN ARRAY:C227(arrItemInOutIds; 1; 1)
INSERT IN ARRAY:C227(arrTax1; 1; 1)
INSERT IN ARRAY:C227(arrTax2; 1; 1)

// add the Opening Line to the first line of the ListBox
arrItemInOutIds{1}:="Opening balance"
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
