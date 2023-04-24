//%attributes = {}
#DECLARE()->$isOnSameComputer
var $serverInfo; $clientInfo : Object


$isOnSameComputer:=False:C215

$serverInfo:=UTIL_getServerSystemInfo

$clientInfo:=Get system info:C1571

// compare properties to decide if we are on the same computer

If ($clientInfo.machineName=$serverInfo.machineName)
	If ($clientInfo.osVersion=$serverInfo.osVersion)
		
		$isOnSameComputer:=True:C214
		
		//add check for network interfaces additionally later maybe
		
	End if 
End if 
