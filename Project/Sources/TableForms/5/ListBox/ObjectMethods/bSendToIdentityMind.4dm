
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (getKeyValue("identityMind.activated"; "false")="true")
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		// #ORDA
		C_OBJECT:C1216($selection)
		$selection:=Create entity selection:C1512([Invoices:5])
		C_OBJECT:C1216($entities)
		$entities:=$selection.om_registers
		C_OBJECT:C1216($filled)
		$filled:=ds:C1482.Registers.query("Link_92_return # null")
		$entities:=$entities.minus($filled)
		C_OBJECT:C1216($logs)
		$logs:=IM_evaluateMoneyTransfers($entities; <>baseCurrency)
End case 