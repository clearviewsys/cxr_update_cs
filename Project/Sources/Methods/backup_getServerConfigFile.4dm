//%attributes = {"executedOnServer":true}
// returns the content of backup configuration file from server

#DECLARE()->$xml : Text

var $backupConfigPath : Text

$backupConfigPath:=Get 4D file:C1418(Backup settings file:K5:58)

If (Test path name:C476($backupConfigPath)=Is a document:K24:1)
	$xml:=Document to text:C1236($backupConfigPath; "UTF-8")
End if 
