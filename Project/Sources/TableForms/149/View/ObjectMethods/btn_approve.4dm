
C_LONGINT:C283($error)
C_TEXT:C284($reference)

$reference:=myRequest("Enter an approval reference information?")

If (OK=1)
	
	READ WRITE:C146([WebEWires:149])
	
	If (Locked:C147([WebEWires:149]))
		LOAD RECORD:C52([WebEWires:149])  //try once to see if we can get a lock
	End if 
	If ([WebEWires:149]Notes:17="")
		[WebEWires:149]Notes:17:=$reference
	Else 
		[WebEWires:149]Notes:17:=$reference+" | "+[WebEWires:149]Notes:17
	End if 
	
	[WebEWires:149]status:16:=20
	createOnChangeNotification(->[WebEWires:149])  //must come before SAVE
	
	SAVE RECORD:C53([WebEWires:149])
	
	//UNLOAD RECORD([WebEWires])
	//READ ONLY([WebEWires])
	
	UNLOAD RECORD:C212([Customers:3])
	READ ONLY:C145([Customers:3])
	LOAD RECORD:C52([Customers:3])
	
	//$error:=createEwireFromWebeWire ([WebEWires]WebEwireID)
	
	//If ($error=0)
	//CANCEL
	//Else 
	//myAlert ("Error creating webEwire. "+String($error))
	//End if 
	
	handleWebEwiresInvoiceBtn
End if 