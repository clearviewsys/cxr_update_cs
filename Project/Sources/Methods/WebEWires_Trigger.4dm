//%attributes = {}

C_LONGINT:C283($0; $iError)


Case of 
	: (Trigger event:C369=On Saving New Record Event:K3:1)
		If ([WebEWires:149]creationDate:15=!00-00-00!)
			[WebEWires:149]creationDate:15:=Current date:C33
		End if 
		
		If ([WebEWires:149]creationTime:31=?00:00:00?)
			[WebEWires:149]creationTime:31:=Current time:C178
		End if 
		
	: (Trigger event:C369=On Saving Existing Record Event:K3:2)
		[WebEWires:149]modifyDate:32:=Current date:C33
		[WebEWires:149]modifyTime:33:=Current time:C178
		
		If (Old:C35([WebEWires:149]status:16)=[WebEWires:149]status:16)  //no status change
		Else 
			CREATE RECORD:C68([WebEWireLogs:151])
			[WebEWireLogs:151]UUID:1:=Generate UUID:C1066
			[WebEWireLogs:151]WebEwireID:7:=[WebEWires:149]WebEwireID:1
			[WebEWireLogs:151]StatusNew:5:=[WebEWires:149]status:16
			[WebEWireLogs:151]StatusOld:4:=Old:C35([WebEWires:149]status:16)
			[WebEWireLogs:151]Notes:6:=WAPI_getRecordFieldChanges(->[WebEWires:149])
			
			SAVE RECORD:C53([WebEWireLogs:151])
			UNLOAD RECORD:C212([WebEWireLogs:151])
			
			//createWebEwireNotifOnStatusChng 
			
			Case of 
				: ([WebEWires:149]status:16=-10)  //cancelled
					[WebEWires:149]isCancelled:20:=True:C214
					
				: ([WebEWires:149]status:16=-20)  //denied
					[WebEWires:149]isCancelled:20:=True:C214
					
				: ([WebEWires:149]status:16=30)
					
					
				Else 
					[WebEWires:149]isCancelled:20:=False:C215
					
			End case 
			
		End if 
		
		If ([WebEWires:149]status:16=20) & ([WebEWires:149]eWireID:18="")  //confirmed but no ewire created
			If ([WebEWires:149]author:34=[WebEWires:149]agentID:29) & ([WebEWires:149]author:34#"")
				//created by an agent and has now been confirmed
				CREATE RECORD:C68([eWires:13])
				$iError:=createEwireFromWebeWire([WebEWires:149]WebEwireID:1)
				SAVE RECORD:C53([eWires:13])
			End if 
		End if 
		
	: (Trigger event:C369=On Deleting Record Event:K3:3)
		
		
End case 


//createOnChangeNotification (->[WebEWires])

$0:=$iError