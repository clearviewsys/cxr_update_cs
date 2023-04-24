//%attributes = {}
// barchcustomersonHold 

C_BOOLEAN:C305($onHold; $1)
C_TEXT:C284($message; $reason)

$onHold:=$1

If ((isUserComplianceOfficer) | (isUserAdministrator) | (isUserManager))
	If ($onHold=True:C214)
		$message:="Are you sure you want to put these customers on hold?"
	Else 
		$message:="Are you sure you want to take selected customers off hold?"
	End if 
	
	CONFIRM:C162($message)
	If (OK=1)
		USE SET:C118("$customers_LBSet")
		
		If ($onHold=True:C214)  // filter out the ones that are already on hold cause we don't want to do extra work for no reason
			QUERY SELECTION:C341([Customers:3]; [Customers:3]isOnHold:52=False:C215)
		Else 
			QUERY SELECTION:C341([Customers:3]; [Customers:3]isOnHold:52=True:C214)
		End if 
		If (Records in selection:C76([Customers:3])>0)
			READ WRITE:C146([Customers:3])
			$message:="what is the reason?"
			$reason:=myRequest($message; "")
			
			If (OK=1)
				If ($message#"")
					If ($onHold=True:C214)
						$message:="Customer put on hold by "+getApplicationUser+" on "+String:C10(Current date:C33)+" for the reason of: "+$reason+CRLF
					Else 
						$message:="Customer taken off hold by "+getApplicationUser+" on "+String:C10(Current date:C33)+" for the reason of: "+$reason+CRLF
					End if 
					APPLY TO SELECTION:C70([Customers:3]; [Customers:3]isOnHold:52:=$onHold)
					If (OK=1)
						APPLY TO SELECTION:C70([Customers:3]; [Customers:3]Comments:43:=$message+[Customers:3]Comments:43)
					End if 
					
				Else 
					myAlert("Sorry but a valid reason must be provided for this request.")
				End if 
			End if 
			
			
			If (OK=1)
				C_LONGINT:C283($n)
				$n:=Records in selection:C76([Customers:3])
				If ($onHold=True:C214)
					myAlert(String:C10($n)+" customers were put on hold.")
					createRecordExceptionLog(->[Customers:3]; "PUT ON HOLD: Batch of Customers"; ""; String:C10($n)+" customers were placed ON HOLD by "+getApplicationUser+CRLF+"Reason: "+$reason)
					
				Else 
					myAlert(String:C10($n)+" customers were taken off hold.")
					createRecordExceptionLog(->[Customers:3]; "TAKE OFF HOLD: Batch of Customers"; ""; String:C10($n)+" customers were taken OFF HOLD by "+getApplicationUser+CRLF+"Reason: "+$reason)
					
				End if 
			End if 
			
			READ ONLY:C145([Customers:3])
		Else 
			myAlert("No relevant record were in the selection to apply the changes. No records were affected.")
		End if 
		
	Else 
		myAlert("No records were affected")
	End if 
	
	
Else 
	myAlert("User is not manager or compliance officer")
End if 