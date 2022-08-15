C_LONGINT:C283($0)
$0:=0

If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			[CashInventory:35]DenominationID:3:=makeDenominationsID([CashInventory:35]Currency:4; [CashInventory:35]Denomination:5)
			[CashInventory:35]CashInventoryID:1:=makeCashInventoryID([CashInventory:35]CashAccountID:2; [CashInventory:35]DenominationID:3)
			setCashInventoryCalcFields
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			[CashInventory:35]DenominationID:3:=makeDenominationsID([CashInventory:35]Currency:4; [CashInventory:35]Denomination:5)
			[CashInventory:35]CashInventoryID:1:=makeCashInventoryID([CashInventory:35]CashAccountID:2; [CashInventory:35]DenominationID:3)
			setCashInventoryCalcFields
			//: (Trigger event=_o_On Loading Record Event)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
	//writeLogTrigger ([cashInventory]TransactionID;$0)
End if 

AUDIT_Trigger
TriggerSync