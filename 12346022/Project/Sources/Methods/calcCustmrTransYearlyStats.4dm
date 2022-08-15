//%attributes = {}
//author: Amir
//date: 3rd Nov 2018
//used for customer transaction yearly statistics report
//assumes [Registers] are selected based on customers, and [Registers] are sorted based on [Register]CustId and [Register]RegisterDate
//calcCustmrTransactStats(
//    ->listBoxPtr;
//    ->arrCustomerIDPtr;
//    ->arrYearsPtr;
//    ->arrTransactionVolumePtr;
//    ->arrAverageBuysPtr;
//    ->arrBuyQuantitiesPtr;
//)
//since the buy and sell add up to same value, just showing buy
//calculates the transaction statistics for customers in selection 
//for each customer, calculates statistics for year by year basis
//calculates total, average and quantity for buy registers.
C_POINTER:C301($1; $listboxPtr)
C_POINTER:C301($2; $arrCustomerIdPtr)
C_POINTER:C301($3; $arrYearsPtr)
C_POINTER:C301($4; $arrTransactionVolumePtr)
C_POINTER:C301($5; $arrAverageBuysPtr)
C_POINTER:C301($6; $arrBuyQuantitiesPtr)
ASSERT:C1129(Count parameters:C259=6; "Expected 6 parameters")

$listboxPtr:=$1
$arrCustomerIdPtr:=$2
$arrYearsPtr:=$3
$arrTransactionVolumePtr:=$4
$arrAverageBuysPtr:=$5
$arrBuyQuantitiesPtr:=$6

READ ONLY:C145([Registers:10])
READ ONLY:C145([Customers:3])

//variables for calculating stats 
C_REAL:C285($totalBuy; $avgBuy)
C_LONGINT:C283($buyQty)
C_LONGINT:C283($previousYear)
C_BOOLEAN:C305($isSameCustomer; $isSameYear)
C_TEXT:C284($previousCustomerId)
C_LONGINT:C283($numRegisters; $numRowsInserted; $listboxIndex; $registerIndex)
$numRegisters:=Records in selection:C76([Registers:10])
$listboxIndex:=1
If ($numRegisters>0)
	//resizing arrays; this is an upper bound; we wont need this many elments since all customers wont have transactions in all years. 
	//The extra empty ones are deleted in the end.
	//done this way to improve performance and avoid inserting element in the loop
	$numRowsInserted:=numRowsPerCustomer*(Records in selection:C76([Customers:3]))
	LISTBOX INSERT ROWS:C913($listboxPtr->; 1; $numRowsInserted)
	
	C_LONGINT:C283($progress)
	C_BOOLEAN:C305($isLoopStopped)
	$progress:=launchProgressBar("Customer transaction statistics")
	$previousCustomerId:=[Registers:10]CustomerID:5
	$previousYear:=Year of:C25([Registers:10]RegisterDate:2)
	$totalBuy:=0
	$avgBuy:=0
	$buyQty:=0
	For ($registerIndex; 1; $numRegisters)
		//if register is for same customer and year, add values
		$isSameCustomer:=([Registers:10]CustomerID:5=$previousCustomerId)
		$isSameYear:=(Year of:C25([Registers:10]RegisterDate:2)=$previousYear)
		If ($isSameCustomer & $isSameYear)
			If ([Registers:10]Debit:8#0)  //buy
				$totalBuy:=$totalBuy+[Registers:10]DebitLocal:23
				$buyQty:=$buyQty+1
			End if 
		Else   //if customer is different or year is different, save previous values
			$arrCustomerIdPtr->{$listboxIndex}:=$previousCustomerId
			$arrYearsPtr->{$listboxIndex}:=$previousYear
			$arrTransactionVolumePtr->{$listboxIndex}:=$totalBuy
			$arrAverageBuysPtr->{$listboxIndex}:=($totalBuy/$buyQty)
			$arrBuyQuantitiesPtr->{$listboxIndex}:=$buyQty
			
			$listboxIndex:=$listboxIndex+1
			//reset values for current register
			$totalBuy:=[Registers:10]DebitLocal:23
			If ([Registers:10]Debit:8#0)
				$buyQty:=1
			Else 
				$buyQty:=0
			End if 
		End if 
		$previousCustomerId:=[Registers:10]CustomerID:5
		$previousYear:=Year of:C25([Registers:10]RegisterDate:2)
		NEXT RECORD:C51([Registers:10])
		
		If ($registerIndex%100=1)
			refreshProgressBar($progress; $registerIndex; $numRegisters)
		End if 
		If (isProgressBarStopped($progress))
			$registerIndex:=$numRegisters+1  //break the loop
			$isLoopStopped:=True:C214
		End if 
	End for 
	If (Not:C34($isLoopStopped))  //if loop was not stopped
		//save last record (last record is not saved and needs to be saved seperately)
		$arrCustomerIdPtr->{$listboxIndex}:=$previousCustomerId
		$arrYearsPtr->{$listboxIndex}:=$previousYear
		$arrTransactionVolumePtr->{$listboxIndex}:=$totalBuy
		$arrAverageBuysPtr->{$listboxIndex}:=($totalBuy/$buyQty)
		$arrBuyQuantitiesPtr->{$listboxIndex}:=$buyQty
		$listboxIndex:=$listboxIndex+1
	End if 
	//delete extra empty rows
	LISTBOX DELETE ROWS:C914($listboxPtr->; $listboxIndex; $numRowsInserted-$listboxIndex+1)
	HIDE PROCESS:C324($progress)
End if 

