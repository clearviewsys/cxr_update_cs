

C_LONGINT:C283($0)

$0:=0
If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			If ([ShipmentLines:98]shipmentLineID:1="")
				[ShipmentLines:98]shipmentLineID:1:=makeshipmentLineID
			End if 
			
			[ShipmentLines:98]shipmentValue:6:=[ShipmentLines:98]QtyShipped:5*[ShipmentLines:98]denomination:4
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			[ShipmentLines:98]shipmentValue:6:=[ShipmentLines:98]QtyShipped:5*[ShipmentLines:98]denomination:4
			[ShipmentLines:98]MissingValue:11:=([ShipmentLines:98]QtyShipped:5-[ShipmentLines:98]QtyReceived:9)*[ShipmentLines:98]denomination:4
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
End if 

AUDIT_Trigger
TriggerSync