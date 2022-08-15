//%attributes = {}
// createCashRegisterID ({cashRegisterID};{name of Cash Register})
// if paramter is ommited then create the defaultCashRegisterID (safe or 00)


C_TEXT:C284($cashRegisterID; $cashRegisterName)

Case of 
	: (Count parameters:C259=0)
		$cashRegisterID:=getDefaultCashRegisterID
		$cashRegisterName:=getDefaultCashRegisterName
		
	: (Count parameters:C259=1)
		$cashRegisterID:=$1
		
	: (Count parameters:C259=2)
		$cashRegisterID:=$1
		$cashRegisterName:=$2
		
End case 

READ ONLY:C145([CashRegisters:33])
QUERY:C277([CashRegisters:33]; [CashRegisters:33]CashRegisterID:1=$cashRegisterID)

If (Records in selection:C76([CashRegisters:33])=0)
	READ WRITE:C146([CashRegisters:33])
	CREATE RECORD:C68([CashRegisters:33])
	[CashRegisters:33]CashRegisterID:1:=$cashRegisterID
	[CashRegisters:33]CashRegisterName:7:=$cashRegisterName
	[CashRegisters:33]autoCreateCashAccounts:9:=True:C214
	
	SAVE RECORD:C53([CashRegisters:33])
	UNLOAD RECORD:C212([CashRegisters:33])
	READ ONLY:C145([CashRegisters:33])
End if 