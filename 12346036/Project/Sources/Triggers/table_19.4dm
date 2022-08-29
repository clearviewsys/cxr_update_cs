C_LONGINT:C283($0)

$0:=0
If (isTriggerEnabled)
	
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			[Flags:19]CountryCurrency:5:=[Flags:19]Country:3+" : "+[Flags:19]CurrencyName:2
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			[Flags:19]CountryCurrency:5:=[Flags:19]Country:3+" : "+[Flags:19]CurrencyName:2
			
			//: (Trigger event=_o_On Loading Record Event)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
End if 

AUDIT_Trigger