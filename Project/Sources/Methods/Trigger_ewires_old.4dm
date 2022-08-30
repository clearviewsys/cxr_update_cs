//%attributes = {}
C_LONGINT:C283($0)
C_TEXT:C284($currency)
C_REAL:C285($amount)

$0:=0
If (isTriggerEnabled)
	
	If ([eWires:13]isPaymentSent:20)
		$amount:=[eWires:13]ToAmount:14
		$currency:=[eWires:13]Currency:12
	Else 
		$amount:=[eWires:13]FromAmount:13
		$currency:=[eWires:13]FromCurrency:11
	End if 
	
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			If ([eWires:13]eWireID:1="")
				[eWires:13]eWireID:1:=makeeWireID  // for first time
			End if 
			
			If ([eWires:13]InvoiceNumber:29="")
				[eWires:13]InvoiceNumber:29:="eWire"
			End if 
			setDateTimeUser(->[eWires:13]SendDate:2; ->[eWires:13]SendTime:3)
			makeeWireSubjectLine
			
			RELATE ONE:C42([eWires:13]LinkID:8)
			If ([eWires:13]CustomerID:15="")
				[eWires:13]CustomerID:15:=[Links:17]CustomerID:14
				[eWires:13]SenderName:7:=[Links:17]CustomerName:15
			End if 
			[eWires:13]RegisterID:24:=createRegister([eWires:13]InvoiceNumber:29; [eWires:13]SendDate:2; ""; "eWire"; [eWires:13]isPaymentSent:20; [eWires:13]CustomerID:15; $amount; $currency; [eWires:13]AccountID:30; ->[eWires:13]; ->[eWires:13]Subject:6)
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			makeeWireSubjectLine
			If ([eWires:13]isSettled:23)
				setDateTimeUserForced(->[eWires:13]ReceiveDate:18; ->[eWires:13]ReceiveTime:19)
				// only when eWire is paid update the register
			End if 
			[eWires:13]RegisterID:24:=createRegister([eWires:13]InvoiceNumber:29; [eWires:13]SendDate:2; [eWires:13]RegisterID:24; "eWire"; [eWires:13]isPaymentSent:20; [eWires:13]CustomerID:15; $amount; $currency; [eWires:13]AccountID:30; ->[eWires:13]; ->[eWires:13]Subject:6)
			
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			//deleteRelatedManyRegister ([eWires]RegisterID)
			
	End case 
	
	writeLogTrigger(eWireID; $0)
End if 