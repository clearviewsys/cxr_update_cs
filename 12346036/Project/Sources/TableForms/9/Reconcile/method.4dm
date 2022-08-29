
If (Form event code:C388=On Load:K2:1)
	START TRANSACTION:C239
	
	TM_Add2Stack(->[Registers:10]; Current method name:C684; Transaction level:C961)
	
	READ WRITE:C146([Registers:10])
	handleAccountsViewRegisters
End if 

GET HIGHLIGHTED RECORDS:C902([Registers:10]; "$selectedSet")

If (Records in set:C195("$selectedSet")>1)  // selecting rows
	initReconcileVars
	//CREATE SET([Registers];"$originalSet")
	COPY NAMED SELECTION:C331([Registers:10]; "$originalSort")
	
	USE SET:C118("$selectedSet")
	getRegisterSums(->vSubDebitsLocal_H; ->vSumCreditsLocal_H; ->vSumBalanceLocal_H; ->vSumDebits_H; ->vSumCredits_H; ->vSumBalance_H)
	USE NAMED SELECTION:C332("$originalSort")
	HIGHLIGHT RECORDS:C656([Registers:10]; "$selectedSet")
	CLEAR NAMED SELECTION:C333("$originalSort")
	CLEAR SET:C117("$selectedSet")
Else 
	initReconcileVars
End if 

If (Form event code:C388=On Close Box:K2:21)
	If (Modified record:C314([Registers:10]))
		CONFIRM:C162("Save reconciled account ?"; "Save"; "Don't Save")
		If (OK=1)
			VALIDATE TRANSACTION:C240
			ACCEPT:C269
		Else 
			CANCEL TRANSACTION:C241
			CANCEL:C270
		End if 
	Else 
		CANCEL TRANSACTION:C241
		CANCEL:C270
		
	End if 
	
	TM_RemoveFromStack
	
End if 

If (Form event code:C388=On Unload:K2:2)
	READ ONLY:C145([Registers:10])
End if 