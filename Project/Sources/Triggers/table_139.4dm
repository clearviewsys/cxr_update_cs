
If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			[CAB_Batch_Logs:139]creationDate:16:=Current date:C33
			[CAB_Batch_Logs:139]Status:4:=0
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record  
			C_LONGINT:C283($stat)
			$stat:=Num:C11([CAB_Batch_Logs:139]isCustomersPulled:12)+Num:C11([CAB_Batch_Logs:139]isInvoicesCreated:11)+\
				Num:C11([CAB_Batch_Logs:139]isProcessed:13)+Num:C11([CAB_Batch_Logs:139]isRegistersCreated:10)+\
				Num:C11([CAB_Batch_Logs:139]isValidated:9)
			
			If ($stat=5)  // all "isXXXX" have been completed
				[CAB_Batch_Logs:139]Status:4:=1
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 

$0:=0