//%attributes = {}
// calcPLOpeningVars ( 1: curr; 2: branch; 3: date; 4: ->opening; 5:->buy;6:->sell; 7: ->inventory; 8: ->avgBuy; 9:->ShortRate; 10: ->sumDebitLC; 11:->sumCreditLC; 12: ->sumProfit; 13: ->sumFees; 14: ->cogs; 15: ->net)

C_LONGINT:C283($i; $n)
C_TEXT:C284($curr; $branchID; $1; $2)
C_DATE:C307($fromDate; $3)
C_LONGINT:C283($n; $m; $i)
C_REAL:C285($openingBuy; $openingSell; $openingBuyRate; $openingShortRate; $openingDebitLC; $openingCreditLC; $openingCOGS; $openingInventory; $openingFeeLC; $openingNet; $openingRate)
C_POINTER:C301($4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $15)
C_REAL:C285($buy; $sell; $rate; $buyLC; $sellLC; $feeLC)
C_REAL:C285($inventory; $avgBuyRate; $shortRate; $profit; $openingProfit; $cogs)

Case of 
	: (Count parameters:C259=15)
		$curr:=$1
		$branchID:=$2
		$fromDate:=$3
	Else 
		ASSERT:C1129(False:C215; "invalid number of params")
End case 


//$n:=PL_queryRegistersLessThanDate ($curr;$branchID;$fromDate)  // queries all relevant registers up to fromDate (not inclusive)
C_DATE:C307($preFromDate)
$preFromDate:=Add to date:C393($fromDate; 0; 0; -1)  // fromDate minus 1 (opening)

$n:=PL_queryRegistersInDateRange($curr; $branchID; !00-00-00!; $preFromDate)  // It is better to use one method for consistency instead of the special opening balance query

$openingBuy:=Sum:C1([Registers:10]Debit:8)
$openingSell:=Sum:C1([Registers:10]Credit:7)
//$openingFee:=Sum([Registers]feeLocal) // wrong fee to add
$openingFeeLC:=Sum:C1([Registers:10]totalFees:30)  // correct fee

$openingDebitLC:=Sum:C1([Registers:10]DebitLocal:23)
$openingCreditLC:=Sum:C1([Registers:10]CreditLocal:24)

$openingInventory:=$openingBuy-$openingSell


For ($i; 1; $n)
	GOTO SELECTED RECORD:C245([Registers:10]; $i)  // load the record
	$buy:=[Registers:10]Debit:8
	$sell:=[Registers:10]Credit:7
	$rate:=[Registers:10]OurRate:25
	$buyLC:=[Registers:10]DebitLocal:23
	$sellLC:=[Registers:10]CreditLocal:24
	$feeLC:=[Registers:10]totalFees:30
	
	PL_calcRowByRowVars($buy; $sell; $rate; $buyLC; $sellLC; $feeLC; ->$inventory; ->$avgBuyRate; ->$shortRate; ->$profit)
	$openingProfit:=$openingProfit+$profit
	//If ($sell>0)
	//$cogs:=($sell*$avgBuyRate)
	$cogs:=$sellLC-$profit  // change in the formula to be consistent with the book definition
	$openingCOGS:=$openingCOGS+$COGS
	//Else 
	//$cogs:=0
	//End if 
End for 

$4->:=$openingInventory
$5->:=$openingBuy
$6->:=$openingSell
$7->:=$inventory
$8->:=$avgBuyRate
$9->:=$shortRate
$10->:=$openingDebitLC  // debitLC (cost of purchase) 
$11->:=$openingCreditLC  // creditLC (revenue from sales)
$12->:=$Openingprofit
$13->:=$openingFeeLC
$14->:=$openingCOGS
$15->:=$openingProfit+$openingFeeLC  // net profit or loss 