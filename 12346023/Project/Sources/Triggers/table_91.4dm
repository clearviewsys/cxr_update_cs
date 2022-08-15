// 
C_LONGINT:C283($0)

$0:=0
If (isTriggerEnabled)
	
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			//[Denominations]DenominationID:=makeDenominationsID   // for first time
			If ([ImportedRows:91]importedRowID:1="")
				[ImportedRows:91]importedRowID:1:=makeimportedRowID
			End if 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			//[Denominations]DenominationID:=makeDenominationsID   // for first time
			
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
	//writeLogTrigger ([Denominations];$0) // activate this line for logging changes
End if 

// Sync_Trigger - activate this line if it is actually 

Case of 
	: ([ImportedRows:91]Amount:10>0)
		[ImportedRows:91]Debit:8:=[ImportedRows:91]Amount:10
		[ImportedRows:91]Credit:9:=0
	: ([ImportedRows:91]Amount:10<0)
		[ImportedRows:91]Debit:8:=0
		[ImportedRows:91]Credit:9:=[ImportedRows:91]Amount:10
	Else 
		[ImportedRows:91]Amount:10:=[ImportedRows:91]Debit:8-[ImportedRows:91]Credit:9
End case 