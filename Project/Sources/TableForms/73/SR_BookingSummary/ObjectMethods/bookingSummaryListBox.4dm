//author: Amir
//16th Dec. 2018
//booking summary double click handler for listbox
//showing details of bookings for given date range, branch, isSettled, and currency
//assumes [Bookings] records contain the proper selection and ordered by currency

//array for details page
ARRAY TEXT:C222(arrCurrencyDetails; 0)
ARRAY TEXT:C222(arrBranchID; 0)
ARRAY DATE:C224(arrValueDate; 0)
ARRAY TEXT:C222(arrIsConfirmed; 0)
ARRAY TEXT:C222(arrIsHonored; 0)
ARRAY REAL:C219(arrBuyDetails; 0)
ARRAY REAL:C219(arrSellDetails; 0)
ARRAY PICTURE:C279(arrDetailsFlag; 0)

C_LONGINT:C283($row)
C_POINTER:C301($columnPtr)
C_TEXT:C284($selectedCurrency)
C_LONGINT:C283($progress)
C_LONGINT:C283($numRecords; $recordIndex; $detailsListBoxIndex)
C_BOOLEAN:C305($isLoopStopped; $currencyRecordsFound)
C_TEXT:C284($TRUE_VALUE; $FALSE_VALUE)
C_PICTURE:C286($currencyPicture)
$TRUE_VALUE:="Y"
$FALSE_VALUE:="N"
$currencyRecordsFound:=False:C215
If (Form event code:C388=On Double Clicked:K2:5)
	$ColumnPtr:=Focus object:C278
	$row:=$ColumnPtr->
	If ($row>0)
		listbox_deleteAllRows(->bookingDetailsListBox)
		$selectedCurrency:=arrCurrencyCode{$row}
		//finding picture of this currency
		QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$selectedCurrency)
		$currencyPicture:=[Currencies:6]Flag:3
		$numRecords:=Records in selection:C76([Bookings:50])
		$recordIndex:=1
		FIRST RECORD:C50([Bookings:50])
		$isLoopStopped:=False:C215
		$progress:=launchProgressBar("Calculating booking details for "+$selectedCurrency)
		While (($recordIndex<=$numRecords) & (Not:C34($isLoopStopped)))
			If ([Bookings:50]Currency:10=$selectedCurrency)
				$currencyRecordsFound:=True:C214
				//save the row
				$detailsListBoxIndex:=listbox_appendRow(->bookingDetailsListBox)
				arrCurrencyDetails{$detailsListBoxIndex}:=$selectedCurrency
				arrBranchID{$detailsListBoxIndex}:=[Bookings:50]BranchID:25
				arrValueDate{$detailsListBoxIndex}:=[Bookings:50]ValueDate:26
				arrDetailsFlag{$detailsListBoxIndex}:=$currencyPicture
				If ([Bookings:50]isConfirmed:15)
					arrIsConfirmed{$detailsListBoxIndex}:=$TRUE_VALUE
				Else 
					arrIsConfirmed{$detailsListBoxIndex}:=$FALSE_VALUE
				End if 
				
				If ([Bookings:50]isHonored:18)
					arrIsHonored{$detailsListBoxIndex}:=$TRUE_VALUE
				Else 
					arrIsHonored{$detailsListBoxIndex}:=$FALSE_VALUE
				End if 
				
				If ([Bookings:50]isSell:7)
					arrBuyDetails{$detailsListBoxIndex}:=0
					arrSellDetails{$detailsListBoxIndex}:=[Bookings:50]Amount:9
				Else 
					arrBuyDetails{$detailsListBoxIndex}:=[Bookings:50]Amount:9
					arrSellDetails{$detailsListBoxIndex}:=0
				End if 
				
			End if 
			
			If (($currencyRecordsFound=True:C214) & ([Bookings:50]Currency:10#$selectedCurrency))
				//break out of loop (since records are ordered by currency)
				$isLoopStopped:=True:C214
			End if 
			NEXT RECORD:C51([Bookings:50])
			$recordIndex:=$recordIndex+1
			If ($recordIndex%5=1)
				refreshProgressBar($progress; $recordIndex; $numRecords)
			End if 
			$isLoopStopped:=isProgressBarStopped($progress)
		End while 
		HIDE PROCESS:C324($progress)
		FORM GOTO PAGE:C247(2)
	End if 
End if 
