//%attributes = {}
[CashInventory:35]SystemTotal:7:=[CashInventory:35]SystemCount:6*[CashInventory:35]Denomination:5
[CashInventory:35]ActualTotal:9:=[CashInventory:35]ActualCount:8*[CashInventory:35]Denomination:5
[CashInventory:35]ShortCount:10:=[CashInventory:35]SystemCount:6-[CashInventory:35]ActualCount:8
[CashInventory:35]ShortValue:11:=[CashInventory:35]ShortCount:10*[CashInventory:35]Denomination:5