//%attributes = {"shared":true}
If (isUserAdministrator)
	
	
	openFormWindow(->[CompanyInfo:7]; "DeleteAllDialog")
	If (OK=1)
		BACKUP:C887
		READ WRITE:C146(*)
		
		
		C_LONGINT:C283($progress)
		C_LONGINT:C283($i; $n)
		
		$progress:=launchProgressBar("Deletion...")
		$n:=1+cbDelRegisters+cbDelBookings+cbDelAccountInOuts+cbDelCashTransactions
		$n:=$n+cbDelCashInOuts+cbDelItemInOuts+cbDelCheques+cbDelInvoices+cbDelWires+cbDelCustomers+cbDelAccounts
		$i:=1
		
		refreshProgressBar($progress; $i; $n)
		
		If (cbDelRegisters=1)
			$i:=$i+1
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Deleting registers")
			
			//ALL RECORDS([Registers])
			//DELETE SELECTION([Registers])
			TRUNCATE TABLE:C1051([Registers:10])
			
		End if 
		
		If (cbDelBookings=1)
			$i:=$i+1
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Deleting Bookings")
			
			//ALL RECORDS([Bookings])
			//DELETE SELECTION([Bookings])
			TRUNCATE TABLE:C1051([Bookings:50])
		End if 
		
		If (cbDelAccountInOuts=1)
			$i:=$i+1
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Deleting Accounts In Out")
			
			//ALL RECORDS([AccountInOuts])
			//DELETE SELECTION([AccountInOuts])
			TRUNCATE TABLE:C1051([AccountInOuts:37])
		End if 
		
		If (cbDelCashTransactions=1)
			$i:=$i+1
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Deleting Cash Transactions")
			
			//ALL RECORDS([CashTransactions])
			//DELETE SELECTION([CashTransactions])
			TRUNCATE TABLE:C1051([CashTransactions:36])
		End if 
		
		If (cbDelCashInOuts=1)
			$i:=$i+1
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Cash Journal")
			
			//ALL RECORDS([CashInOuts])
			//DELETE SELECTION([CashInOuts])
			TRUNCATE TABLE:C1051([CashInOuts:32])
			
			//ALL RECORDS([TellerProofLines])
			//DELETE SELECTION([TellerProofLines])
			TRUNCATE TABLE:C1051([TellerProofLines:79])
			
			//ALL RECORDS([TellerProof])
			//DELETE SELECTION([TellerProof])
			TRUNCATE TABLE:C1051([TellerProof:78])
			
		End if 
		
		If (cbDelItemInOuts=1)
			$i:=$i+1
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Items In & Out")
			
			//ALL RECORDS([ItemInOuts])
			//DELETE SELECTION([ItemInOuts])
			TRUNCATE TABLE:C1051([ItemInOuts:40])
		End if 
		
		If (cbDelCheques=1)
			$i:=$i+1
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Deleting Cheques")
			
			//ALL RECORDS([Cheques])
			//DELETE SELECTION([Cheques])
			TRUNCATE TABLE:C1051([Cheques:1])
		End if 
		
		If (cbDelInvoices=1)
			$i:=$i+1
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Deleting Invoices")
			
			//ALL RECORDS([Invoices])
			//DELETE SELECTION([Invoices])
			TRUNCATE TABLE:C1051([Invoices:5])
		End if 
		
		If (cbDelWires=1)
			$i:=$i+1
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Deleting Wires")
			
			//ALL RECORDS([Wires])
			//DELETE SELECTION([Wires])
			TRUNCATE TABLE:C1051([Wires:8])
		End if 
		
		
		If (cbDelMessages=1)
			$i:=$i+1
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Deleting Messages")
			
			//ALL RECORDS([MESSAGES])
			//DELETE SELECTION([MESSAGES])
			TRUNCATE TABLE:C1051([MESSAGES:11])
		End if 
		
		If (cbDeleWires=1)
			$i:=$i+1
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Deleting eWires")
			
			//ALL RECORDS([eWires])
			//DELETE SELECTION([eWires])
			TRUNCATE TABLE:C1051([eWires:13])
		End if 
		
		If (cbDelCustomers=1)
			$i:=$i+1
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Deleting Customers")
			
			//ALL RECORDS([Customers])
			//DELETE SELECTION([Customers])
			TRUNCATE TABLE:C1051([Customers:3])
		End if 
		
		If (cbDelAccounts=1)
			$i:=$i+1
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Deleting Accounts")
			
			//ALL RECORDS([Accounts])
			//DELETE SELECTION([Accounts])
			TRUNCATE TABLE:C1051([Accounts:9])
			
			//ALL RECORDS([MainAccounts])
			//DELETE SELECTION([MainAccounts])
			TRUNCATE TABLE:C1051([MainAccounts:28])
			
		End if 
		FLUSH CACHE:C297
		READ ONLY:C145(*)
		HIDE PROCESS:C324($progress)
		
	End if 
	
Else 
	myAlert("Only the administrator may use this feature.")
End if 
