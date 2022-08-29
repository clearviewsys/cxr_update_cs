//%attributes = {}
//
//Method: LogUserLoggingIn
//Purpose: Create a new record in User_Log for a user logging in
//and clean up any open records for the given username 
//#ORDA
//

C_TEXT:C284($1; $userName; $machineName)
C_OBJECT:C1216($record; $newRecord; $existingRecords)

Case of 
	: (Count parameters:C259=1)
		$userName:=$1
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
		
		//While (Not(End selection([User_Log])))
		For each ($record; $existingRecords)
			$record.DateOut:=Current date:C33
			$record.TimeOut:=Current time:C178
			$record.IsCleanLogout:=False:C215
			$record.save()
			
		End for each 
	End if 
End if 


$newRecord:=ds:C1482.User_Log.new()
$newRecord.UserName:=$userName
$newRecord.MachineName:=$machineName
$newRecord.DateIn:=Current date:C33
$newRecord.TimeIn:=Current time:C178
$newRecord.IsCleanLogout:=False:C215
$newRecord.save()
