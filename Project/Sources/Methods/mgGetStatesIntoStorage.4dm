//%attributes = {}
// fills Storage.mgStates by calling MoneyGram SOAP API
// call this method to refresh or create list of states in Storage

C_OBJECT:C1216($result)
C_COLLECTION:C1488($0)

$result:=mgGetStates

If ($result.success)
	
	Use (Storage:C1525)
		If (Storage:C1525.mgStates=Null:C1517)
			Storage:C1525.mgStates:=New shared collection:C1527
		End if 
	End use 
	
	Use (Storage:C1525.mgStates)
		OB_CopyCollection($result.result; Storage:C1525.mgStates)
	End use 
	
	$0:=$result.result
	
End if 
