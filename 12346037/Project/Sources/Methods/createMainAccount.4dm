//%attributes = {}
// createMainAccount (accountID; accountName; accountType ; accountDesc; isDebit; isReserved)
C_TEXT:C284($mainAccountID; $mainAccountName; $mainAccountDesc; $1; $2; $4)
C_LONGINT:C283($3; $mainAccountType)
C_BOOLEAN:C305($5; $6; $isDebit; $isReserved)

$mainAccountID:=$1
$mainAccountName:=$2
$mainAccountType:=$3
$mainAccountDesc:=$4
$isDebit:=$5
$isReserved:=$6


READ ONLY:C145([MainAccounts:28])
QUERY:C277([MainAccounts:28]; [MainAccounts:28]MainAccountID:1=$mainAccountID)
If (Records in selection:C76([MainAccounts:28])=0)
	//CONFIRM("The main account '"+$mainAccountName+"' doesn't exist. Do you want to create it?")
	//If (OK=1)
	READ WRITE:C146([MainAccounts:28])
	CREATE RECORD:C68([MainAccounts:28])
	[MainAccounts:28]MainAccountID:1:=$mainAccountID
	//[MainAccounts]_:=$mainAccountName
	[MainAccounts:28]AccountType:4:=getAccountType($mainAccountType)  // assets
	[MainAccounts:28]Description:3:=$mainAccountDesc
	
	[MainAccounts:28]isDebit:5:=$isDebit
	[MainAccounts:28]isReservedBySystem:7:=$isReserved
	SAVE RECORD:C53([MainAccounts:28])
	UNLOAD RECORD:C212([MainAccounts:28])
	READ ONLY:C145([MainAccounts:28])
	//End if 
End if 
