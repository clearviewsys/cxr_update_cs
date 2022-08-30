//%attributes = {"executedOnServer":true}
// execute on server property set

C_BOOLEAN:C305($0)
C_OBJECT:C1216($activity)
C_COLLECTION:C1488($found)

$0:=False:C215
$activity:=Get process activity:C1495(Processes only:K5:35)

$found:=$activity.processes.query("type = :1"; Backup process:K36:24)

If ($found#Null:C1517)
	If ($found.length>0)
		$0:=True:C214
	End if 
End if 
