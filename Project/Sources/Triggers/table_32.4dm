C_LONGINT:C283($0)
$0:=0

If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			[CashInOuts:32]DenominationID:5:=makeDenominationsID([CashInOuts:32]Currency:6; [CashInOuts:32]Denomination:7)
			[CashInOuts:32]CashInventoryID:3:=makeCashInventoryID([CashInOuts:32]CashAccountID:4; [CashInOuts:32]DenominationID:5)
			[CashInOuts:32]TotalIn:10:=[CashInOuts:32]QtyIN:8*[CashInOuts:32]Denomination:7
			[CashInOuts:32]TotalOut:11:=[CashInOuts:32]QtyOut:9*[CashInOuts:32]Denomination:7
			updateRelatedCashInventory(Trigger event:C369)
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			[CashInOuts:32]DenominationID:5:=makeDenominationsID([CashInOuts:32]Currency:6; [CashInOuts:32]Denomination:7)
			[CashInOuts:32]CashInventoryID:3:=makeCashInventoryID([CashInOuts:32]CashAccountID:4; [CashInOuts:32]DenominationID:5)
			[CashInOuts:32]TotalIn:10:=[CashInOuts:32]QtyIN:8*[CashInOuts:32]Denomination:7
			[CashInOuts:32]TotalOut:11:=[CashInOuts:32]QtyOut:9*[CashInOuts:32]Denomination:7
			updateRelatedCashInventory(Trigger event:C369)
			
			//: (Trigger event=_o_On Loading Record Event)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			updateRelatedCashInventory(Trigger event:C369)
	End case 
	
	//writeLogTrigger ([CashInOuts]TransactionID;$0)
End if 

AUDIT_Trigger
TriggerSync