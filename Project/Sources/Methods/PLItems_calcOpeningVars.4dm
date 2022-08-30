//%attributes = {}
// PLItems_calcOpeningVars ( 1: itemID; 2: branch; 3: date; 4: ->opening; 5:->buy;6:->sell; 7: ->inventory; 8: ->avgBuy; 9:->ShortRate; 10: ->sumDebitLC; 11:->sumCreditLC; 12: ->sumProfit; 13: ->sumFees; 14: ->cogs; 15: ->net)

C_LONGINT:C283($i; $n)
C_TEXT:C284($itemID; $branchID; $1; $2)
C_DATE:C307($fromDate; $3)
C_LONGINT:C283($n; $m; $i)
C_REAL:C285($buy; $sell; $rate; $buyLC; $sellLC; $feeLC; $openingBuy; $openingSell; $openingBuyRate; $openingShortRate; $openingDebitLC; $openingCreditLC; $openingCOGS; $openingInventory; $openingFee; $openingNet; $openingRate)
C_POINTER:C301($4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $15)
C_REAL:C285($inventory; $avgBuyRate; $shortRate; $profit; $openingProfit)
C_REAL:C285($cogs)
Case of 
	: (Count parameters:C259=15)
		$itemID:=$1
		$branchID:=$2
		$fromDate:=$3
	Else 
		ASSERT:C1129(False:C215; "invalid number of params")
End case 

$n:=PL_queryItemsIOInDateRange($itemID; $branchID; !00-00-00!; $fromDate)

FIRST RECORD:C50([ItemInOuts:40])
For ($i; 1; $n)
	If ([ItemInOuts:40]Qty:8#0)
		$rate:=([ItemInOuts:40]Amount:22)/([ItemInOuts:40]Qty:8)
	End if 
	$openingFee:=$openingFee+[ItemInOuts:40]FeeLocal:19
	If ([ItemInOuts:40]isSold:7=True:C214)
		$sell:=[ItemInOuts:40]Qty:8
		$sellLC:=[ItemInOuts:40]Amount:22
		$openingSell:=$openingSell+[ItemInOuts:40]Qty:8
		$openingCreditLC:=$openingCreditLC+[ItemInOuts:40]Amount:22
		
	Else 
		$buy:=[ItemInOuts:40]Qty:8
		$buyLC:=[ItemInOuts:40]Amount:22
		$openingBuy:=$openingBuy+[ItemInOuts:40]Qty:8
		$openingDebitLC:=$openingDebitLC+[ItemInOuts:40]Amount:22
	End if 
	$feeLC:=[ItemInOuts:40]FeeLocal:19
	
	PL_calcRowByRowVars($buy; $sell; $rate; $buyLC; $sellLC; $feeLC; ->$inventory; ->$avgBuyRate; ->$shortRate; ->$profit)
	$openingProfit:=$openingProfit+$profit
	If ($sell>0)
		$cogs:=($sell*$avgBuyRate)
		$openingCOGS:=$openingCOGS+$COGS
	Else 
		$cogs:=0
	End if 
	NEXT RECORD:C51([ItemInOuts:40])
End for 
$openingInventory:=$openingBuy-$openingSell


$4->:=$openingInventory
$5->:=$openingBuy
$6->:=$openingSell
$7->:=$inventory
$8->:=$avgBuyRate
$9->:=$shortRate
$10->:=$openingDebitLC  // debitLC (cost of purchase) 
$11->:=$openingCreditLC  // creditLC (revenue from sales)
$12->:=$Openingprofit
$13->:=$openingFee
$14->:=$openingCOGS
$15->:=$openingProfit+$openingFee  // net profit or loss 