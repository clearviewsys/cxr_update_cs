//%attributes = {}
READ ONLY:C145([CashInOuts:32])
FIRST RECORD:C50([CashInventory:35])
While (Not:C34(End selection:C36([CashInventory:35])))
	READ WRITE:C146([CashInventory:35])
	LOAD RECORD:C52([CashInventory:35])
	RELATE MANY:C262([CashInventory:35]CashInventoryID:1)  // load the cash inouts
	
	[CashInventory:35]SystemCount:6:=Sum:C1([CashInOuts:32]QtyIN:8)-Sum:C1([CashInOuts:32]QtyOut:9)
	[CashInventory:35]SystemTotal:7:=[CashInventory:35]SystemCount:6*[CashInventory:35]Denomination:5
	SAVE RECORD:C53([CashInventory:35])
	READ ONLY:C145([CashInventory:35])
	NEXT RECORD:C51([CashInventory:35])
End while 
If (Records in set:C195("LockedSet")>0)
	USE SET:C118("LockedSet")
	myAlert("These records seem to be locked and therefore not updated. Please try to release "+"and update again.")
End if 