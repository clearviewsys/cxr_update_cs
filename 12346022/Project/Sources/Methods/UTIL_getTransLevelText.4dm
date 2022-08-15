//%attributes = {}
C_TEXT:C284($0)

If (Transaction level:C961>0) | (Current user:C182="designer")
	$0:="T level "+String:C10(Transaction level:C961)+"*"+String:C10(Current time:C178)
Else 
	$0:=""
End if 