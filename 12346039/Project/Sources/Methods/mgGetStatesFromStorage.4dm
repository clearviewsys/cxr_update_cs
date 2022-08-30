//%attributes = {}
C_COLLECTION:C1488($0)
C_BOOLEAN:C305($1; $fetchStates)  // call SOAP API to get states if there are none in storage

If (Count parameters:C259>0)
	$fetchStates:=$1
Else 
	$fetchStates:=False:C215
End if 

If (Storage:C1525.mgStates=Null:C1517)
	If ($fetchStates)
		$0:=mgGetStatesIntoStorage
	End if 
Else 
	$0:=Storage:C1525.mgStates.copy()  // return normal collection, not shared one
End if 
