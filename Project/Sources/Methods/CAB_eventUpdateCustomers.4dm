//%attributes = {}
// designed to be run by calendar events
// self contained - no parameters needed
// checks  [CAB_Batch_Logs] for invoices/registers that need to have the customers checked
// 11/29/22


C_OBJECT:C1216($status; $batch; $es)
C_OBJECT:C1216($invoice; $invoices)
C_LONGINT:C283($i; $n; $progress)
C_REAL:C285($r)
C_COLLECTION:C1488($col)
C_TEXT:C284($id)
C_BOOLEAN:C305($success; $doShowProg)
C_TIME:C306($start)

$success:=True:C214

// do query on [CAB_Batch_Logs] and find customers

$es:=ds:C1482.CAB_Batch_Logs.query("isValidated == :1 "+\
"AND isCustomersPulled == :2 "+\
"AND isInvoicesCreated == :3 "+\
"AND isRegistersCreated == :4 "+\
"AND isProcessed == :5"; \
1; 0; 1; 1; 0)

If ($es.length=0)
	//$es:=ds.CAB_Batch_Logs.all()
End if 


If ($es.length>0)
	For each ($batch; $es)
		// find related invoices here based on the $batch.batchID
		//$invoices:=ds.Invoices.query("om_registers.metaData.batchID == :1"; $batch.BatchID)
		
		$col:=ds:C1482.Registers.query("metaData.batchID == :1"; $batch.BatchID).distinct("CustomerID")
		
		If ($col.length>0)
			
			$n:=$col.length
			$i:=1
			
			$doShowProg:=Choose:C955(getKeyValue("AML.rules.progress.show"; "true")="true"; True:C214; False:C215)
			
			If ($doShowProg)
				$start:=Current time:C178
				$progress:=Progress New
			End if 
			
			//update customers
			For each ($id; $col)
				If (Length:C16($id)<9)
					$success:=$success & (CAB_queryCustomerID(String:C10(Num:C11($id); "000000000")))
				Else 
					$success:=$success & (CAB_queryCustomerID($id))
				End if 
				
				If ($doShowProg)
					If (Mod:C98($i; 100)=0)
						Progress SET TITLE($progress; "Updating customers:  "+$id)
						$r:=$i/$n
						Progress SET PROGRESS($progress; $r; String:C10($i)+" of "+String:C10($n)+" elapsed: "+String:C10(Current time:C178-$start))
					End if 
				End if 
				
				$i:=$i+1
			End for each 
			
			Progress QUIT($progress)
			
			// mark the  [CAB_Batch_Logs]isCustomersPulled:=True 
			
			$batch.isCustomersPulled:=Num:C11($success)
			$status:=$batch.save()
			
			If ($doShowProg)
				If ($success)
					iH_Notify("Importing customers"; String:C10(Current time:C178)+" Customers were updated successfully"; 10)
				Else 
					//error handling here
					iH_Notify("Importing customers"; String:C10(Current time:C178)+" The customer's import process finished and it was not successful"; 10)
				End if 
			End if 
			
		End if 
		
	End for each 
End if 

CAB_log("----------------------------------------------------------------------")
CAB_log("Importing customers process finished at: Date: "+String:C10(Current date:C33(*))+" Time: "+String:C10(Current time:C178(*)))
CAB_log("----------------------------------------------------------------------")
