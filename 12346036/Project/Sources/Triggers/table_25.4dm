C_LONGINT:C283($0)
C_TEXT:C284($plainPass)
C_OBJECT:C1216($options)
$0:=0  //Assume the database request will be granted
If (isTriggerEnabled)
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			
			If ([Users:25]isHashed:36#True:C214)
				$plainPass:=[Users:25]Password:4
				$options:=New object:C1471("algorithm"; "bcrypt"; "cost"; "10")
				[Users:25]Password:4:=Generate password hash:C1533($plainPass; $options)
				[Users:25]isHashed:36:=True:C214
			End if 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
			If ([Users:25]isHashed:36#True:C214)
				$plainPass:=[Users:25]Password:4
				$options:=New object:C1471("algorithm"; "bcrypt"; "cost"; "10")
				[Users:25]Password:4:=Generate password hash:C1533($plainPass; $options)
				[Users:25]isHashed:36:=True:C214
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
	writeLogTrigger([Users:25]UserID:1; $0)
End if 

AUDIT_Trigger
TriggerSync