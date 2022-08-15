
C_LONGINT:C283($0)
$0:=0
If (isTriggerEnabled)
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[KYC2020Log:159]CheckDate:1:=Current date:C33(*)
			[KYC2020Log:159]CheckTime:3:=Current time:C178(*)
	End case 
End if 
TriggerSync

