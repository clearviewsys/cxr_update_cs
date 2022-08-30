//%attributes = {}
//author: Amir
//date: 15th Dec 2018
//helper method for calculating summary of bookings 
//used for summary of bookings screen report
//assumes [Bookings] records contain the proper selection and ordered by currency
//calculateBookingSummaryReport(
//->arrCurrencyPtr;
//->arrTotalBuyPtr;
//->arrTotalSellPtr;
//->summaryListBoxPtr
//->arrFlagsPtr
//->arrCurrencyName
//->arrNoOfBuy
//)


C_POINTER:C301($1; $arrCurrencyCodePtr)
C_POINTER:C301($2; $arrTotalBuyPtr)
C_POINTER:C301($3; $arrTotalSellPtr)
C_POINTER:C301($4; $summaryListBoxPtr)
C_POINTER:C301($5; $arrFlagsPtr)
C_POINTER:C301($6; $arrCurrencyNamePtr)
C_POINTER:C301($7; $arrNoOfBuyPtr)
C_POINTER:C301($8; $arrNoOfSellPtr)
ASSERT:C1129(Count parameters:C259=8; "Expected 8 parameters")
$arrCurrencyCodePtr:=$1
$arrTotalBuyPtr:=$2
$arrTotalSellPtr:=$3
$summaryListBoxPtr:=$4
$arrFlagsPtr:=$5
$arrCurrencyNamePtr:=$6
$arrNoOfBuyPtr:=$7
$arrNoOfSellPtr:=$8

READ ONLY:C145([Bookings:50])
READ ONLY:C145([Currencies:6])
C_LONGINT:C283($progress)
C_TEXT:C284($previousCurrency)
C_REAL:C285($previousCurrencySumBuy)
C_REAL:C285($previousCurrencySumSell)
C_LONGINT:C283($numRecords; $recordIndex; $summaryListBoxIndex; $previousNumBuys; $previousNumSells)
C_BOOLEAN:C305($isLoopStopped)
$numRecords:=Records in selection:C76([Bookings:50])
$recordIndex:=1
FIRST RECORD:C50([Bookings:50])
ALL RECORDS:C47([Currencies:6])
$previousCurrency:=[Bookings:50]Currency:10
$isLoopStopped:=False:C215  //for checking if user canceled the progress bar
If ($numRecords>0)
	$progress:=launchProgressBar("Calculating bookings summary")
	While (($recordIndex<=$numRecords) & (Not:C34($isLoopStopped)))
		If ($previousCurrency=[Bookings:50]Currency:10)  //same currency: add values
			If ([Bookings:50]isSell:7)
				$previousCurrencySumSell:=$previousCurrencySumSell+[Bookings:50]Amount:9
				$previousNumSells:=$previousNumSells+1
			Else 
				$previousCurrencySumBuy:=$previousCurrencySumBuy+[Bookings:50]Amount:9
				$previousNumBuys:=$previousNumBuys+1
			End if 
		Else   //new currency: save previous
			$summaryListBoxIndex:=listbox_appendRow($summaryListBoxPtr)
			$arrCurrencyCodePtr->{$summaryListBoxIndex}:=$previousCurrency
			$arrTotalBuyPtr->{$summaryListBoxIndex}:=$previousCurrencySumBuy
			$arrTotalSellPtr->{$summaryListBoxIndex}:=$previousCurrencySumSell
			//adding the currency picture
			QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$previousCurrency)
			$arrFlagsPtr->{$summaryListBoxIndex}:=[Currencies:6]Flag:3
			$arrCurrencyNamePtr->{$summaryListBoxIndex}:=[Currencies:6]Name:2
			$arrNoOfBuyPtr->{$summaryListBoxIndex}:=$previousNumBuys
			$arrNoOfSellPtr->{$summaryListBoxIndex}:=$previousNumSells
			If ([Bookings:50]isSell:7)
				$previousCurrencySumSell:=[Bookings:50]Amount:9
				$previousCurrencySumBuy:=0
				$previousNumBuys:=0
				$previousNumSells:=1
			Else 
				$previousCurrencySumSell:=0
				$previousCurrencySumBuy:=[Bookings:50]Amount:9
				$previousNumBuys:=1
				$previousNumSells:=0
			End if 
		End if 
		$recordIndex:=$recordIndex+1
		$previousCurrency:=[Bookings:50]Currency:10
		NEXT RECORD:C51([Bookings:50])
		If ($recordIndex%5=1)
			refreshProgressBar($progress; $recordIndex; $numRecords)
		End if 
		$isLoopStopped:=isProgressBarStopped($progress)
	End while 
	//save last record since it is not saved
	If (Not:C34($isLoopStopped))
		$summaryListBoxIndex:=listbox_appendRow($summaryListBoxPtr)
		$arrCurrencyCodePtr->{$summaryListBoxIndex}:=$previousCurrency
		$arrTotalBuyPtr->{$summaryListBoxIndex}:=$previousCurrencySumBuy
		$arrTotalSellPtr->{$summaryListBoxIndex}:=$previousCurrencySumSell
		QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$previousCurrency)
		$arrFlagsPtr->{$summaryListBoxIndex}:=[Currencies:6]Flag:3
		$arrCurrencyNamePtr->{$summaryListBoxIndex}:=[Currencies:6]Name:2
		$arrNoOfBuyPtr->{$summaryListBoxIndex}:=$previousNumBuys
		$arrNoOfSellPtr->{$summaryListBoxIndex}:=$previousNumSells
	End if 
	HIDE PROCESS:C324($progress)
	
End if 