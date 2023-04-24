//%attributes = {}
C_BOOLEAN:C305($0)

$0:=((([Accounts:9]isCashAccount:3) | ([Accounts:9]isBankAccount:7) | ([Accounts:9]isInventory:18)) & Not:C34([Registers:10]isTransfer:3))

