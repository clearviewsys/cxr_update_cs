//author: Amir
//28th Oct. 2018
//annual currency form double click handler for listbox


C_LONGINT:C283($row)
C_POINTER:C301($columnPtr)
C_TEXT:C284($title; $currency; $branch)
C_LONGINT:C283($year)
C_BOOLEAN:C305($filterByBranch; $showBuy; $showSell)
C_DATE:C307($fromDate; $toDate)
C_LONGINT:C283($year)

If (Form event code:C388=On Double Clicked:K2:5)
	$ColumnPtr:=Focus object:C278
	$row:=$ColumnPtr->
	If ($row>0)
		//determining filtering criteria for registers
		$currency:=arrCurrencyCodes{$row}
		$showBuy:=(showBuyChkboxPtr->=1)
		$showSell:=(showSellChkboxPtr->=1)
		$filterByBranch:=(branchSelectionPtr->#1)
		READ ONLY:C145([Registers:10])
		QUERY:C277([Registers:10]; [Registers:10]Currency:19=$currency)
		Case of   //show buy, sell, or both
			: (($showBuy=True:C214) & ($showSell#True:C214))
				QUERY SELECTION:C341([Registers:10]; [Registers:10]Debit:8>0)
			: (($showSell=True:C214) & ($showBuy#True:C214))
				QUERY SELECTION:C341([Registers:10]; [Registers:10]Credit:7>0)
		End case 
		If ($filterByBranch=True:C214)
			QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=arrBranches{branchSelectionPtr->})
		End if 
		//filter by year
		$year:=yearSelectionValues{yearSelectionPtr->}
		$fromDate:=Date:C102(String:C10($year)+"-01-01T00:00:00")
		$toDate:=Date:C102(String:C10($year+1)+"-01-01T00:00:00")
		QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$fromDate)
		QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2<$toDate)
		orderByRegisters
		FORM GOTO PAGE:C247(2)
		$title:=String:C10($year)+" annual summary for currency "+$currency
		If ($filterByBranch=True:C214)
			$title:=$title+" , and branch "+arrBranches{branchSelectionPtr->}
		End if 
		OBJECT SET TITLE:C194(*; "ReportTitle"; $title)
	End if 
End if 
