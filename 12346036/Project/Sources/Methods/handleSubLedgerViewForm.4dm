//%attributes = {}
handleViewForm
C_LONGINT:C283(mainListBox)

If (Form event code:C388=On Load:K2:1)
	//SET FIELD RELATION([Registers]CustomerID;Automatic;Manual)  // activate the automatic relation 
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	
	RELATE ONE:C42([Accounts:9]MainAccountID:2)  // display the information about the parent account
	RELATE ONE:C42([Accounts:9]Currency:6)
	
	showObjectOnTrue([Accounts:9]isRestrictedToManagers:14; "isRestricted")
	If (isUserAllowedToViewThisAccount)
		//handleAccountsViewRegisters 
		
		If (cbApplyDateRange=1)
			selectRegistersInDateRange([Accounts:9]AccountID:1; vFromDate; vToDate; False:C215)
		Else 
			relateMany(->[Registers:10]; ->[Registers:10]AccountID:6; ->[Accounts:9]AccountID:1)
		End if 
		orderByRegisters
		SELECTION TO ARRAY:C260([Registers:10]RegisterID:1; acc_arrRegisterIDs; [Registers:10]isValidated:35; acc_arrIsValidated; [Registers:10]RegisterDate:2; acc_arrDates; [Registers:10]CustomerID:5; acc_arrCustomers; [Registers:10]Debit:8; acc_arrIns; [Registers:10]Credit:7; acc_arrOuts; [Registers:10]Currency:19; acc_arrCurrencies; [Registers:10]OurRate:25; acc_arrRates; [Registers:10]feeLocal:29; acc_arrFees; [Registers:10]DebitLocal:23; acc_arrDebits; [Registers:10]CreditLocal:24; acc_arrCredits; [Registers:10]InvoiceNumber:10; acc_arrInvoiceIDs; [Registers:10]isTransfer:3; acc_arrIsTransfer)
		relateMany(->[Registers:10]; ->[Registers:10]AccountID:6; ->[Accounts:9]AccountID:1)
		
		
		C_REAL:C285(vOpeningBalance; vTransferIn; vTransferOut; vTotalPurchase; vTotalSold; vBalanceRemaining; vMarketRate; vMarketValue)
		C_REAL:C285(vCostofPurchase; vRevenueFromSales; vTotalFees; vCOGS; vProfitOrLoss; vProfitBeforeFees; vAvgBuyRate; vAvgSellRate; vAvgSpread)
		
		If (cbApplyDateRange=1)
			CREATE SET:C116([Registers:10]; "$originalRegistersSet")
			QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2<vFromDate)
			vOpeningBalance:=Sum:C1([Registers:10]Debit:8)-Sum:C1([Registers:10]Credit:7)
			USE SET:C118("$originalRegistersSet")
			CLEAR SET:C117("$originalRegistersSet")
			QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
			QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
		Else 
			vOpeningBalance:=0
		End if 
		
		CREATE SET:C116([Registers:10]; "$currentRegisters")
		QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=True:C214)
		vTransferIn:=Sum:C1([Registers:10]Debit:8)
		vTransferOut:=Sum:C1([Registers:10]Credit:7)
		USE SET:C118("$currentRegisters")
		CLEAR SET:C117("$currentRegisters")
		
		vTotalPurchase:=Sum:C1([Registers:10]Debit:8)-vTransferIn
		vTotalSold:=Sum:C1([Registers:10]Credit:7)-vTransferOut
		
		vMarketRate:=[Currencies:6]SpotRateLocal:17
		vBalanceRemaining:=vOpeningBalance+vTransferIn-vTransferOut+vTotalPurchase-vTotalSold
		vMarketValue:=vBalanceRemaining*vMarketRate
		
		vCostOfPurchase:=Sum:C1([Registers:10]DebitLocal:23)
		vRevenueFromSales:=Sum:C1([Registers:10]CreditLocal:24)
		vTotalFees:=Sum:C1([Registers:10]totalFees:30)  //
		vAvgBuyRate:=vCostOfPurchase/vTotalPurchase
		vAvgSellRate:=vRevenueFromSales/vTotalSold
		vAvgSpread:=vAvgSellRate-vAvgBuyRate
		If (vBalanceRemaining>0)
			vCOGS:=vAvgBuyRate*vTotalSold
		Else 
			vCOGS:=0
		End if 
		vProfitBeforeFees:=vRevenueFromSales-vCOGS
		vProfitOrLoss:=vProfitBeforeFees+vTotalFees
		
	End if 
	
	REDRAW:C174(mainListBox)
End if 

If (Form event code:C388=On Unload:K2:2)
	SET FIELD RELATION:C919([Registers:10]CustomerID:5; Manual:K51:3; Manual:K51:3)
End if 