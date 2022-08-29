C_LONGINT:C283($k)

If (Form event code:C388=On Clicked:K2:4)
	//clear all previous values
	For ($k; 1; numCurrencies)
		arrJanValues{$k}:=0
		arrFebValues{$k}:=0
		arrMarValues{$k}:=0
		arrAprValues{$k}:=0
		arrMayValues{$k}:=0
		arrJunValues{$k}:=0
		arrJulValues{$k}:=0
		arrAugValues{$k}:=0
		arrSepValues{$k}:=0
		arrOctValues{$k}:=0
		arrNovValues{$k}:=0
		arrDecValues{$k}:=0
	End for 
	//determine all the search criteria
	C_BOOLEAN:C305($showBuy; $showSell; $showLocalCurrency; $showCount; $showVolume; $filterByBranch)
	$showBuy:=(showBuyChkboxPtr->=1)
	$showSell:=(showSellChkboxPtr->=1)
	$filterByBranch:=(branchSelectionPtr->#1)  //anything other than first option is selected (first option is no branch)
	$showLocalCurrency:=(localCurrencyChkbox->=1)
	$showCount:=(countRadButtonPtr->=1)
	$showVolume:=(volumeRadButtonPtr->=1)
	C_LONGINT:C283($year)
	$year:=yearSelectionValues{yearSelectionPtr->}  //year that the user selected
	ARRAY DATE:C224($arrDateValues; 13)  //array of start of each month (used for quering)
	$arrDateValues{1}:=Date:C102(String:C10($year)+"-01-01T00:00:00")  //start of January
	$arrDateValues{2}:=Date:C102(String:C10($year)+"-02-01T00:00:00")  //start of Feb
	$arrDateValues{3}:=Date:C102(String:C10($year)+"-03-01T00:00:00")
	$arrDateValues{4}:=Date:C102(String:C10($year)+"-04-01T00:00:00")
	$arrDateValues{5}:=Date:C102(String:C10($year)+"-05-01T00:00:00")
	$arrDateValues{6}:=Date:C102(String:C10($year)+"-06-01T00:00:00")
	$arrDateValues{7}:=Date:C102(String:C10($year)+"-07-01T00:00:00")
	$arrDateValues{8}:=Date:C102(String:C10($year)+"-08-01T00:00:00")
	$arrDateValues{9}:=Date:C102(String:C10($year)+"-09-01T00:00:00")
	$arrDateValues{10}:=Date:C102(String:C10($year)+"-10-01T00:00:00")
	$arrDateValues{11}:=Date:C102(String:C10($year)+"-11-01T00:00:00")
	$arrDateValues{12}:=Date:C102(String:C10($year)+"-12-01T00:00:00")  //start of Dec
	$arrDateValues{13}:=Date:C102(String:C10($year+1)+"-01-01T00:00:00")  //start of Jan for next year
	
	READ ONLY:C145([Registers:10])
	QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=$arrDateValues{1}; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<$arrDateValues{13})
	If ($filterByBranch=True:C214)
		QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=arrBranches{branchSelectionPtr->})
	End if 
	COPY NAMED SELECTION:C331([Registers:10]; "RegistersInDateRange")
	C_LONGINT:C283($monthIndex; $registerIndex; $rowIndex; $numMonths; $progress)
	$monthIndex:=1
	$numMonths:=Size of array:C274($arrDateValues)
	$progress:=launchProgressBar("Calculating...")
	C_TEXT:C284($currency; $previousCurrency)
	C_REAL:C285($volumeBuy; $volumeSell; $volumeBuyLocal; $volumeSellLocal)
	C_LONGINT:C283($countBuy; $countSell)
	Repeat   //for each month
		USE NAMED SELECTION:C332("RegistersInDateRange")
		QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$arrDateValues{$monthIndex})
		QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2<$arrDateValues{$monthIndex+1})
		ORDER BY:C49([Registers:10]; [Registers:10]Currency:19)
		FIRST RECORD:C50([Registers:10])
		$previousCurrency:=[Registers:10]Currency:19
		$volumeBuy:=0
		$volumeSell:=0
		$volumeBuyLocal:=0
		$volumeSellLocal:=0
		$countBuy:=0
		$countSell:=0
		For ($registerIndex; 1; Records in selection:C76([Registers:10]))
			$currency:=[Registers:10]Currency:19
			If ($currency=$previousCurrency)  //values must be added
				$volumeBuy:=$volumeBuy+[Registers:10]Debit:8
				$volumeSell:=$volumeSell+[Registers:10]Credit:7
				$volumeBuyLocal:=$volumeBuyLocal+[Registers:10]DebitLocal:23
				$volumeSellLocal:=$volumeSellLocal+[Registers:10]CreditLocal:24
				If ([Registers:10]Debit:8>0)  //buy 
					$countBuy:=$countBuy+1
				End if 
				If ([Registers:10]Credit:7>0)  //sell
					$countSell:=$countSell+1
				End if 
				
			Else   //this currency is different; save values for previous currency
				$rowIndex:=Find in array:C230(arrCurrencyCodes; $previousCurrency)  //row index for corresponding currency in listbox
				
				saveCountOrVolumeInArrElement(arrMonthArraysPtr{$monthIndex}; $rowIndex; $showBuy; $showSell; $showCount; $showVolume; $showLocalCurrency; $volumeBuy; $volumeSell; $volumeBuyLocal; $volumeSellLocal; $countBuy; $countSell)
				
				//reset values for next currency
				$volumeBuy:=[Registers:10]Debit:8
				$volumeSell:=[Registers:10]Credit:7
				$volumeBuyLocal:=[Registers:10]DebitLocal:23
				$volumeSellLocal:=[Registers:10]CreditLocal:24
				If ([Registers:10]Debit:8>0)
					$countBuy:=1
					$countSell:=0
				End if 
				If ([Registers:10]Credit:7>0)
					$countBuy:=0
					$countSell:=1
				End if 
			End if 
			
			$previousCurrency:=[Registers:10]Currency:19
			NEXT RECORD:C51([Registers:10])
		End for 
		
		//saving last value; since it is not saved
		$rowIndex:=Find in array:C230(arrCurrencyCodes; $previousCurrency)
		saveCountOrVolumeInArrElement(arrMonthArraysPtr{$monthIndex}; $rowIndex; $showBuy; $showSell; $showCount; $showVolume; $showLocalCurrency; $volumeBuy; $volumeSell; $volumeBuyLocal; $volumeSellLocal; $countBuy; $countSell)
		
		$monthIndex:=$monthIndex+1
		
		refreshProgressBar($progress; $monthIndex; $numMonths)
	Until (($monthIndex>($numMonths-1)) | (isProgressBarStopped($progress)))
	HIDE PROCESS:C324($progress)
	
End if 