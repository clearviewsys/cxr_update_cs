

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (<>CLIENTCODE="Xchange@") | (Current user:C182="designer")  //for Blake ExchangeOfAmerica
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (<>CLIENTCODE="Xchange@") | (Current user:C182="designer")  //for Blake ExchangeOfAmerica
			
			exportXOMRegisters
		Else 
			
			
			C_TEXT:C284($filePath)
			$filePath:=getFilePathByID("GlobalWareExportPath")
			
			C_DATE:C307(vFromDate; vToDate)
			vFromDate:=Current date:C33
			vToDate:=Current date:C33
			
			requestDateRange
			
			// select all base currency cash transactions only
			QUERY:C277([Accounts:9]; [Accounts:9]isCashAccount:3=True:C214)
			
			// select all registers that are cash
			RELATE MANY SELECTION:C340([Registers:10]AccountID:6)
			
			// select all register that are local currency but not transfers (trades only)
			QUERY SELECTION:C341([Registers:10]; [Registers:10]Currency:19=<>BASECURRENCY; *)
			QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]isTransfer:3=False:C215)
			
			QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
			QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
			
			
			exportGWInvoices_($filePath; vFromDate; vToDate)
			
			QUERY:C277([Customers:3]; [Customers:3]CreationDate:54>=vFromDate; *)
			QUERY:C277([Customers:3];  & ; [Customers:3]CreationDate:54<=vToDate)
			
			exportGWCustomers($filePath; vFromDate; vToDate)
			
		End if 
		
End case 