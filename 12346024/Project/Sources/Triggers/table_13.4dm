C_LONGINT:C283($0)
C_TEXT:C284($currency; $currStatus)
C_LONGINT:C283($i)
C_POINTER:C301($ptrField)
C_REAL:C285($amount)
C_OBJECT:C1216($entity)

$0:=0
If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			setTableID(->[eWires:13]eWireID:1; makeeWireID)
			setDateTimeUser(->[eWires:13]creationDate:53; ->[eWires:13]creationTime:54; ->[eWires:13]createdByUser:51)
			
			
			setDateTimeUser(->[eWires:13]SendDate:2; ->[eWires:13]SendTime:3)
			
			If ([eWires:13]isSettled:23=True:C214)  // if the money has been paid - just in case fetched and marked settled
				setDateTimeUserForced(->[eWires:13]ReceiveDate:18; ->[eWires:13]ReceiveTime:19)
			End if 
			
			makeeWireSubjectLine
			[eWires:13]Status:22:=getEwireStatus
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			
			$currStatus:=Old:C35([eWires:13]Status:22)
			
			If ($currStatus="Settled") | ($currStatus="Complete")  //roll back all changes do not allow
				
				For ($i; 1; Get last field number:C255(->[eWires:13]))
					If (Is field number valid:C1000(->[eWires:13]; $i))
						$ptrField:=Field:C253(Table:C252(->[eWires:13]); $i)
						
						$ptrField->:=Old:C35($ptrField->)
					End if 
				End for 
				
			Else 
				
				If ([eWires:13]fromCountry:9="")
					[eWires:13]fromCountry:9:=getCountryNameByCode([eWires:13]fromCountryCode:111)
				End if 
				
				If ([eWires:13]toCountry:10="")
					[eWires:13]toCountry:10:=getCountryNameByCode([eWires:13]toCountryCode:112)
				End if 
				
				If (([eWires:13]isSettled:23=True:C214) & (Old:C35([eWires:13]isSettled:23)=False:C215))  // if the money has been paid
					setDateTimeUserForced(->[eWires:13]ReceiveDate:18; ->[eWires:13]ReceiveTime:19)
				End if 
				
				keepBooleanFieldStatic(->[eWires:13]isSettled:23; True:C214)
				keepBooleanFieldStatic(->[eWires:13]isLocked:79; True:C214)
				keepBooleanFieldStatic(->[eWires:13]isCancelled:34; True:C214)
				
				If (Old:C35([eWires:13]lockedDate:80)#!00-00-00!) & (Old:C35([eWires:13]lockedDate:80)#[eWires:13]lockedDate:80)
					[eWires:13]lockedDate:80:=Old:C35([eWires:13]lockedDate:80)  //revert
				End if 
				
				If (Old:C35([eWires:13]lockedTime:81)#?00:00:00?) & (Old:C35([eWires:13]lockedTime:81)#[eWires:13]lockedTime:81)
					[eWires:13]lockedTime:81:=Old:C35([eWires:13]lockedTime:81)  //revert
				End if 
				
				If (Old:C35([eWires:13]lockedIP:82)#"") & (Old:C35([eWires:13]lockedIP:82)#[eWires:13]lockedIP:82)
					[eWires:13]lockedIP:82:=Old:C35([eWires:13]lockedIP:82)  //revert
				End if 
				
				If (Old:C35([eWires:13]lockedSite:83)#"") & (Old:C35([eWires:13]lockedSite:83)#[eWires:13]lockedSite:83)
					[eWires:13]lockedSite:83:=Old:C35([eWires:13]lockedSite:83)  //revert
				End if 
				
				If (Old:C35([eWires:13]invoiceID_origin:86)#"") & ([eWires:13]invoiceID_origin:86="")
					[eWires:13]invoiceID_origin:86:=Old:C35([eWires:13]invoiceID_origin:86)
				End if 
				
				If (Old:C35([eWires:13]customerID_origin:84)#"") & ([eWires:13]customerID_origin:84="")
					[eWires:13]customerID_origin:84:=Old:C35([eWires:13]customerID_origin:84)
				End if 
				
				If (Old:C35([eWires:13]linkID_origin:85)#"") & ([eWires:13]linkID_origin:85="")
					[eWires:13]linkID_origin:85:=Old:C35([eWires:13]linkID_origin:85)
				End if 
				
				If (Old:C35([eWires:13]registerID_origin:91)#"") & ([eWires:13]registerID_origin:91="")
					[eWires:13]registerID_origin:91:=Old:C35([eWires:13]registerID_origin:91)
				End if 
				
				
				
				makeeWireSubjectLine
				setDateTimeUserForced(->[eWires:13]modificationDate:55; ->[eWires:13]modificationTime:56; ->[eWires:13]modifiedByUser:52)
				[eWires:13]Status:22:=getEwireStatus
				
				////------- UPDATE WEBEWIRE IF RELATED -------
				If ([eWires:13]WebEwireID:123="")  //nothing related stop
				Else 
					READ WRITE:C146([WebEWires:149])
					QUERY:C277([WebEWires:149]; [WebEWires:149]WebEwireID:1=[eWires:13]WebEwireID:123)
					
					If (Records in selection:C76([WebEWires:149])=1)
						C_TEXT:C284($finalStatus)
						
						$finalStatus:="Settled"
						
						Case of 
							: ([eWires:13]Status:22=$finalStatus)
								[WebEWires:149]status:16:=40
								
							: ([eWires:13]Status:22="Cancelled")
								[WebEWires:149]status:16:=-10
								[WebEWires:149]isCancelled:20:=True:C214
								
							: ([eWires:13]Status:22="Invoiced")
								[WebEWires:149]status:16:=30
								
							: ([eWires:13]Status:22="Fetched")
								[WebEWires:149]status:16:=30
								
							: ([eWires:13]Status:22="Sent")
								[WebEWires:149]status:16:=30
								
							Else 
								//don't change anything
						End case 
						
						If (Old:C35([WebEWires:149]status:16)=[WebEWires:149]status:16)  //no change
						Else 
							SAVE RECORD:C53([WebEWires:149])
						End if 
						
					End if 
					
					UNLOAD RECORD:C212([WebEWires:149])
					REDUCE SELECTION:C351([WebEWires:149]; 0)
					READ ONLY:C145([WebEWires:149])
				End if 
				
				
			End if 
			
			
			
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			ABORT:C156
			
	End case 
	
	writeLogTrigger([eWires:13]eWireID:1; $0)
End if 

AUDIT_Trigger
TriggerSync