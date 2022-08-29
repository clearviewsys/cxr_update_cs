//%attributes = {}
// INV_handlevCustomerID

C_LONGINT:C283($counteWires)
C_TEXT:C284(vCustomerID; vCustomerGroup)
C_LONGINT:C283($activeWebeWires)


pickCustomer(->vCustomerID)
If (OK=1)
	setvCustomerID(vCustomerID)
Else 
	setvCustomerID(Old:C35([Invoices:5]CustomerID:2))
End if 
//handleFocusBorder ("focus_vCustomerID")

handlePhoneField(->[Customers:3]HomeTel:6)
handlePhoneField(->[Customers:3]WorkTel:12)
handlePhoneField(->[Customers:3]CellPhone:13)



If (vCustomerID="")
	vCustomerID:=getWalkInCustomerID
End if 

If ((Form event code:C388=On Losing Focus:K2:8) | (Form event code:C388=On Data Change:K2:15))
	
	
	If (isPictureIDExpired([Customers:3]PictureID_ExpiryDate:71))
		colorizeExpiredDate(->[Customers:3]PictureID_ExpiryDate:71)
		myAlert("Main Picture ID has expired for this customer!")
	End if 
	
	setVisibleIff(([Customers:3]AML_HighRisk:24=1); "l_highrisk")
	setVisibleIff(([Customers:3]AML_isSuspicious:49=True:C214); "l_suspicious")
	setVisibleIff(([Customers:3]isOnHold:52=True:C214); "l_onHold")
	
	
	If ([Customers:3]isOnHold:52)
		myAlert("This customer is ON HOLD. Reason: "+[Customers:3]AML_OnHoldNotes:127+CRLF+[Customers:3]Comments:43)
		myAlert("This invoice cannot be saved unless customer is taken off hold!")
	Else 
		If ([Customers:3]AML_isSuspicious:49)
			myAlert("This customer has been tagged as suspicious."+CRLF+"Reason: "+[Customers:3]AML_SuspiciousNotes:125+CRLF+[Customers:3]Comments:43)
			[Invoices:5]isSuspicious:30:=True:C214
		End if 
		
	End if 
	
	//If (isDateWithinRange ([Customers]DOB;2))
	//myAlert ("Wish "+[Customers]FullName+" happy birthday!"+" DOB: "+String([Customers]DOB))
	//End if 
	
	
	
	If (<>doSanctionCheckOnInvoice)
		//The below funciton was commented out, which was causing sanction 
		//checks to not be performed despite being selected in server preferences
		xCheckCustomerDuringInvoice
	End if 
	
	If (<>ReviewCustomerAfterNDays>0)
		
	End if 
	
	// new features added in version 3.497
	// _____________________________________________________
	setInvoiceCustomerFields
	
	If (Is new record:C668([Invoices:5]))
		C_LONGINT:C283($activeBookings; $activeNotes; $activeMessages; $activeeWires)
		
		$activeBookings:=selectActiveBookingsForCustomer(vCustomerID)
		$activeNotes:=selectNotesForCustomer(vCustomerID)
		$activeMessages:=selectActiveMessagesFromCust(vCustomerID)
		$activeeWires:=selectActiveeWiresForCustomer(vCustomerID)
		$activeWebeWires:=selectActiveWebeWires4Customer(vCustomerID)  //9/10/20
		
		If ($activeBookings>0)
			//ALERT("There are "+String($activeBookings)+" active bookings for this customer")
			showObjectOnTrue(($activeBookings>0); "b_Bookings")
			//myAlert ("This customer has an outstanding booking.")
			iH_Notify("Alert"; "This customer has an outstanding booking."; 5)
			handleInvoiceBookingButton
		End if 
		
		If ($activeNotes>0)
			//displaySelectedRecords (->[CallLogs])
			openFormWindow(->[CallLogs:51]; "view")
			//DIALOG([CallLogs];"View")
		End if 
		
		If ($activeMessages>0)
			displaySelectedRecords(->[MESSAGES:11])
		End if 
		
		If ($activeeWires>0)
			displaySelectedRecords(->[eWires:13])
			setVisibleIff($activeeWires>0; "eWiresReceived@")
		End if 
		
		If ($activeWebeWires>0)
			//myAlert ("This customer has an outstanding Web eWire.")
			iH_Notify("Alert"; "This customer has an outstanding Web eWire."; 5)
		End if 
		
	End if 
	
	If ((vCustomerID#getWalkInCustomerID) & (vCustomerID#getSelfCustomerID) & (<>doCheck24HrsRule))
		
		C_OBJECT:C1216($pastTransactions)
		$pastTransactions:=selectCustomersPastRegisters(vCustomerID; <>checkNPreviousDays; VINVOICENUMBER)
		If (($pastTransactions.length>0) & ([Customers:3]AML_IgnoreRepeatTransWarn:108=False:C215))
			CREATE SET:C116([Registers:10]; "$OrigSet")
			USE ENTITY SELECTION:C1513($pastTransactions)
			displayCustomerJournalList
			
			USE SET:C118("$OrigSet")
			CLEAR SET:C117("$OrigSet")
		End if 
		
	End if 
	
	
	
End if 