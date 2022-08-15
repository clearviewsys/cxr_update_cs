
C_TEXT:C284($reason)

myConfirm("Are you sure you want to deny this?")

If (OK=1)
	
	$reason:=myRequest("Please document the reason for this denial.")
	
	If ($reason="")
	Else 
		READ WRITE:C146([WebEWires:149])
		
		If (Locked:C147([WebEWires:149]))
			LOAD RECORD:C52([WebEWires:149])  //try once to see if we can get a lock
		End if 
		
		If (Locked:C147([WebEWires:149])=False:C215)
			[WebEWires:149]Notes:17:=[WebEWires:149]Notes:17+$reason
			[WebEWires:149]status:16:=-20
			createOnChangeNotification(->[WebEWires:149])  //must come before SAVE
			SAVE RECORD:C53([WebEWires:149])
			UNLOAD RECORD:C212([WebEWires:149])
			
			UNLOAD RECORD:C212([Customers:3])
			READ ONLY:C145([Customers:3])
			
			CANCEL:C270
		Else 
			READ ONLY:C145([WebEWires:149])
			myAlert("The WebEwire could not be cancelled at this time.")
		End if 
		
	End if 
	
End if 