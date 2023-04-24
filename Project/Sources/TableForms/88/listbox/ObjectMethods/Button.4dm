
myAlert("This button restores all the deleted records currently visible on this list. Make sure this is exactly what you want to achieve.")

CONFIRM:C162("Are you sure you would like to restore (undo) this record."; "Yes"; "No")


If (OK=1)
	//backupNow 
	If (isUserAdministrator)
		QUERY SELECTION:C341([RegistersAuditTrail:88]; [RegistersAuditTrail:88]ActionTrigger:47="DEL")
		CREATE SET:C116([RegistersAuditTrail:88]; "$tempAuditTrailSet")
		APPLY TO SELECTION:C70([RegistersAuditTrail:88]; restoreRegisterFromAuditTrail)
		USE SET:C118("$tempAuditTrailSet")
		READ WRITE:C146([RegistersAuditTrail:88])
		DELETE SELECTION:C66([RegistersAuditTrail:88])
		READ ONLY:C145([RegistersAuditTrail:88])
		CLEAR SET:C117("$tempAuditTrailSet")
		
		
	Else 
		myAlert("You need to be an administrator to use this feature")
	End if 
	
Else 
	BEEP:C151
End if 

//createRegisterAuditTrail