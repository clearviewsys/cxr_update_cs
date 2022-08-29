//%attributes = {}
//
//Method: LogUserLoggingOut
//Purpose: Add the dateOut and timeOut in User_Log for a user logging out  
//#ORDA
//

C_TEXT:C284($1; $username; $machineName)
C_OBJECT:C1216($newRecord; $existingRecords)

Case of 
	: (Count parameters:C259=1)
		$username:=$1
	: (Count parameters:C259=2)
		$userName:=$1
		$machineName:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$existingRecords:=ds:C1482.User_Log.query("UserName = :1"; $userName)
If ($existingRecords#Null:C1517)
	$existingRecords:=$existingRecords.query("MachineName = :1"; $machineName)
	If ($existingRecords#Null:C1517)
		$existingRecords:=$existingRecords.query("DateOut=00/00/00")
		
		
		
		If ($existingRecords.length>=1)
			
			
			$newRecord:=$existingRecords.last()
			$newRecord.DateOut:=Current date:C33
			$newRecord.TimeOut:=Current time:C178
			$newRecord.IsCleanLogout:=True:C214
			$newRecord.save()
			
		End if 
	End if 
End if 

