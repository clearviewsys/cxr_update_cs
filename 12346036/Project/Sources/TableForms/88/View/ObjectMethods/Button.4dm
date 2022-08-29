CONFIRM:C162("Are you sure you would like to restore (undo) this record."; "Yes"; "No")
If (OK=1)
	C_TEXT:C284($auditTrailID)
	$auditTrailID:=[RegistersAuditTrail:88]AuditTrailID:46
	
	
	restoreRegisterFromAuditTrail
	ALERT:C41("Register "+[RegistersAuditTrail:88]orig_RegisterID:1+" restored!")
	
	
	QUERY:C277([RegistersAuditTrail:88]; [RegistersAuditTrail:88]AuditTrailID:46=$auditTrailID)
	If (Records in selection:C76([RegistersAuditTrail:88])=1)
		
		READ WRITE:C146([RegistersAuditTrail:88])
		DELETE SELECTION:C66([RegistersAuditTrail:88])
		READ ONLY:C145([RegistersAuditTrail:88])
		ALERT:C41("Record "+$auditTrailID+" deleted.")
		//deleteHighlightedRecords (->[RegistersAuditTrail];"$RegistersAuditTrail_LBSet")
		
	Else 
		BEEP:C151
	End if 
	
	
	
Else 
	BEEP:C151
End if 

//createRegisterAuditTrail