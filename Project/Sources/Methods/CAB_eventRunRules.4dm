//%attributes = {}
// designed to be run by calendar events
// self contained - no parameters needed
// checks  [CAB_Batch_Logs] for invoices/registers that need to be processed
// 11/29/22

C_OBJECT:C1216($es; $batch; $invoices; $status)


// do query on [CAB_Batch_Logs] and find invoices to be checked
If (getKeyValue("cab.testMode"; "false")="true")
	$es:=ds:C1482.CAB_Batch_Logs.query("isValidated == :1 "+\
		"AND isInvoicesCreated == :2 "+\
		"AND isRegistersCreated == :3 "+\
		"AND isProcessed == :4"; \
		1; 1; 1; 0)
Else 
	$es:=ds:C1482.CAB_Batch_Logs.query("isValidated == :1 "+\
		"AND isCustomersPulled == :2 "+\
		"AND isInvoicesCreated == :3 "+\
		"AND isRegistersCreated == :4 "+\
		"AND isProcessed == :5"; \
		1; 1; 1; 1; 0)
End if 

//initStorageObject

If ($es.length=0)
	//$es:=ds.CAB_Batch_Logs.all() // ONLY FOR TESTING
End if 

If ($es.length>0)
	For each ($batch; $es)
		// find related invoices here based on the $batch.batchID
		$invoices:=ds:C1482.Invoices.query("om_registers.metaData.batchID == :1"; $batch.BatchID)
		
		If ($invoices.length>0)
			USE ENTITY SELECTION:C1513($invoices)
			
			If (getKeyValue("CAB.testMode"; "false")="true")
				iH_Notify("Running Rules"; String:C10(Current time:C178)+": "+String:C10($invoices.length)+" invoices being evaluated")
			End if 
			
			// apply aml rules to selection of invoices
			agg_applyRulesToInvoices(newDateRange(!00-00-00!; !00-00-00!; False:C215))
			
			// ---- NEED TO UPDATE CAB_BATCH_LOGS -------
			
			$batch.isProcessed:=1
			
			$status:=$batch.save()
			If ($status.success)
				
			Else 
				CAB_notify($batch.BatchID+" not saved and set to isProcessed")
			End if 
			REDUCE SELECTION:C351([Invoices:5]; 0)
		End if 
		
	End for each 
End if 



