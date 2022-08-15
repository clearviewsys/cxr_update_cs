

// to finish

// loop thru the "DEL" and re-delete from the current invoice
// do I only do this for the current site ???

C_LONGINT:C283($i; $count)

If (Current user:C182="designer")
	
	myConfirm("This will DELETE registers. Have you disabled SYNC deletion control as needed. Do you want to continue? ")
	
	If (OK=1)
		$count:=0
		
		ARRAY TEXT:C222($recordArray; 0)
		
		QUERY:C277([IC_FailedRecords:49]; [IC_FailedRecords:49]tableNo:2=Table:C252(->[Invoices:5]))
		
		SELECTION TO ARRAY:C260([IC_FailedRecords:49]recordID:3; $recordArray)
		QUERY WITH ARRAY:C644([RegistersAuditTrail:88]orig_InvoiceNumber:12; $recordArray)
		QUERY SELECTION:C341([RegistersAuditTrail:88]; [RegistersAuditTrail:88]ActionTrigger:47="DEL")
		
		
		If (Records in selection:C76([RegistersAuditTrail:88])>0)
			
			SELECTION TO ARRAY:C260([RegistersAuditTrail:88]AuditTrailID:46; $recordArray)
			
			READ WRITE:C146([Registers:10])
			
			FIRST RECORD:C50([RegistersAuditTrail:88])
			
			For ($i; 1; Size of array:C274($recordArray))
				QUERY:C277([RegistersAuditTrail:88]; [RegistersAuditTrail:88]AuditTrailID:46=$recordArray{$i})
				QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=[RegistersAuditTrail:88]orig_RegisterID:1)
				
				If (Records in selection:C76([Registers:10])=1) & ([Registers:10]BranchID:39=getBranchID)
					DELETE SELECTION:C66([Registers:10])
					$count:=$count+1
				End if 
				
			End for 
			
			READ ONLY:C145([Registers:10])
			
			myAlert("Complete: deleted "+String:C10($count)+" registers")
			
		Else 
			myAlert("No [RegistersAuditTrail] to display.")
		End if 
		
	End if 
	
	ALL RECORDS:C47([IC_FailedRecords:49])
	
Else 
	myAlert("Only available to CXR designers")
End if 