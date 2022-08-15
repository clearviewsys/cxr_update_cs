C_LONGINT:C283($0)
If (isTriggerEnabled)
	
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			If ([Bookings:50]BookingID:1="")
				[Bookings:50]BookingID:1:=makeBookingID
			End if 
			
			handleBookingCalcInTrigger
			
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			handleBookingCalcInTrigger
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
	writeLogTrigger([Bookings:50]BookingID:1; $0)
End if 

AUDIT_Trigger
TriggerSync