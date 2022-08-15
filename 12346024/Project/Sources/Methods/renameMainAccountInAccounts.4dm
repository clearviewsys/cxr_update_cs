//%attributes = {}
// renamemainAccountID (accountID)
// this method will rename

C_TEXT:C284($oldName; $newName; $accountName; $1)

$accountName:=$1

$oldName:=$accountName
$newName:=Request:C163("Rename to:"; $accountName)

CONFIRM:C162("Are you sure you want to replace "+$oldName+" to "+$newName+"?")

If ((OK=1) & ($oldName#$newName))
	// Accounts
	[MainAccounts:28]MainAccountID:1:=$newName
	
	READ WRITE:C146([Accounts:9])
	QUERY:C277([Accounts:9]; [Accounts:9]MainAccountID:2=$oldName)
	APPLY TO SELECTION:C70([Accounts:9]; [Accounts:9]MainAccountID:2:=$newName)
	
Else 
	myAlert("Nothing was affected")
End if 
