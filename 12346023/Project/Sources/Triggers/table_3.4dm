C_LONGINT:C283($0; $iError)

$iError:=0



If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			If ([Customers:3]CustomerID:1="")
				[Customers:3]CustomerID:1:=makeCustomerID
			End if 
			makeCustomerFullName
			setDateTimeUser(->[Customers:3]CreationDate:54; ->[Customers:3]CreationTime:55; ->[Customers:3]CreatedByUserID:58)
			[Customers:3]Email:17:=strRemoveSpaces([Customers:3]Email:17)
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			makeCustomerFullName
			setDateTimeUserForced(->[Customers:3]ModificationDate:56; ->[Customers:3]ModificationTime:57; ->[Customers:3]ModifiedByUserID:59)
			[Customers:3]Email:17:=strRemoveSpaces([Customers:3]Email:17)
			
			//This is for Email Validator, it checks if the email has been changes and unchecks the isVaildEmail feild @viktor
			//If (Old([Customers]Email)#[Customers]Email)
			//[Customers]isValidEmail:=False
			//End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			createRecordExceptionLog(->[Customers:3]; "Customer Deleted:"+[Customers:3]CustomerID:1; [Customers:3]CustomerID:1; getSerializedCustomerRec)
			
			
	End case 
	writeLogTrigger([Customers:3]CustomerID:1; $iError)
End if 

//createOnChangeNotification (->[Customers])
AUDIT_Trigger
TriggerSync

$0:=$iError