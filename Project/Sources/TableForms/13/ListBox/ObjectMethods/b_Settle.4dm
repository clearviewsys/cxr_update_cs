If (isUserAdministrator)
	USE SET:C118("$ewires_LBSet")
	If (Records in set:C195("$ewires_LBSet")>0)
		C_TEXT:C284($ref)
		$ref:=Request:C163("Reference:")
		If ((OK=1) & ($ref#""))
			CONFIRM:C162("Are you sure you want to settle the selected eWires?"; "Settle"; "NO")
			If (OK=1)
				READ WRITE:C146([eWires:13])
				APPLY TO SELECTION:C70([eWires:13]; [eWires:13]isSettled:23:=True:C214)
				APPLY TO SELECTION:C70([eWires:13]; [eWires:13]AgentInternalRef:40:="Auto-"+$ref)
				READ ONLY:C145([eWires:13])
			End if 
		Else 
			myAlert("No eWires were touched!")
		End if 
	Else 
		myAlert("Some lines should be highlighted first!")
	End if 
End if 