//%attributes = {}
// updateRelatedCashInventory (database event)

// this method must be called from CashTransactions Trigger only


C_LONGINT:C283($event; $1)
$event:=$1

READ WRITE:C146([CashInventory:35])
CREATE RELATED ONE:C65([CashInOuts:32]CashInventoryID:3)
LOAD RECORD:C52([CashInventory:35])

[CashInventory:35]CashInventoryID:1:=[CashInOuts:32]CashInventoryID:3
[CashInventory:35]CashAccountID:2:=[CashInOuts:32]CashAccountID:4
[CashInventory:35]Currency:4:=[CashInOuts:32]Currency:6
[CashInventory:35]Denomination:5:=[CashInOuts:32]Denomination:7
[CashInventory:35]DenominationID:3:=[CashInOuts:32]DenominationID:5
Case of 
	: ($event=On Saving New Record Event:K3:1)
		[CashInventory:35]SystemCount:6:=[CashInventory:35]SystemCount:6+[CashInOuts:32]QtyIN:8-[CashInOuts:32]QtyOut:9
		
	: ($event=On Saving Existing Record Event:K3:2)
		[CashInventory:35]SystemCount:6:=[CashInventory:35]SystemCount:6-Old:C35([CashInOuts:32]QtyIN:8)+Old:C35([CashInOuts:32]QtyOut:9)
		[CashInventory:35]SystemCount:6:=[CashInventory:35]SystemCount:6+[CashInOuts:32]QtyIN:8-[CashInOuts:32]QtyOut:9
		
	: ($event=On Deleting Record Event:K3:3)
		[CashInventory:35]SystemCount:6:=[CashInventory:35]SystemCount:6-([CashInOuts:32]QtyIN:8)+([CashInOuts:32]QtyOut:9)
End case 

[CashInventory:35]SystemTotal:7:=[CashInventory:35]SystemCount:6*[CashInventory:35]Denomination:5
SAVE RELATED ONE:C43([CashInOuts:32]CashInventoryID:3)
UNLOAD RECORD:C212([CashInventory:35])
READ ONLY:C145([CashInventory:35])