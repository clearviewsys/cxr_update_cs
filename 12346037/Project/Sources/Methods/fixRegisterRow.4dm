//%attributes = {}

// fixRegisterRow
// DO NOT RENAME THIS PROCEDURE (used in execute command by updateRegi...) 

RELATE ONE:C42([Registers:10]InvoiceNumber:10)
If (Records in selection:C76([Invoices:5])=1)
	If ([Invoices:5]CustomerID:2#"")
		[Registers:10]CustomerID:5:=[Invoices:5]CustomerID:2
	End if 
	If ([Invoices:5]invoiceDate:44#nullDate)
		[Registers:10]RegisterDate:2:=[Invoices:5]invoiceDate:44
	Else 
		[Registers:10]RegisterDate:2:=[Invoices:5]CreationDate:13
	End if 
	//[Registers]isInternal:=[Invoices]isTransfer
End if 

If ([Registers:10]RegisterDate:2=nullDate)  // after all done if the register date is still 00/00/00
	[Registers:10]RegisterDate:2:=[Registers:10]CreationDate:14
End if 

Case of 
	: ([Registers:10]InternalTableNumber:17=Table:C252(->[Cheques:1]))
		READ ONLY:C145([Cheques:1])
		QUERY:C277([Cheques:1]; [Cheques:1]RegisterID:6=[Registers:10]RegisterID:1)
		If ([Cheques:1]AccountID:7#[Registers:10]AccountID:6)
			[Registers:10]Comments:9:=[Registers:10]Comments:9+"--  Fixed: register account ID: "+[Registers:10]AccountID:6+" was not consistent with cheque account ID."
			[Registers:10]AccountID:6:=[Cheques:1]AccountID:7
			[Registers:10]isFlagged:11:=True:C214
		End if 
		
	: ([Registers:10]InternalTableNumber:17=Table:C252(->[eWires:13]))
		READ ONLY:C145([eWires:13])
		QUERY:C277([eWires:13]; [eWires:13]RegisterID:24=[Registers:10]RegisterID:1)
		If ([eWires:13]AccountID:30#[Registers:10]AccountID:6)
			[Registers:10]Comments:9:=[Registers:10]Comments:9+"--  Fixed: register account ID: "+[Registers:10]AccountID:6+" was not consistent with eWire account ID."
			[Registers:10]AccountID:6:=[eWires:13]AccountID:30
			[Registers:10]isFlagged:11:=True:C214
		End if 
		
		
End case 