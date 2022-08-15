//%attributes = {}
// renameAccountID ({accountID})
// this method will rename

C_TEXT:C284($oldName; $newName; $accountName; $1)



Case of 
	: (Count parameters:C259=1)
		$accountName:=$1
		QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$accountName)
	Else 
		pickAccounts(->$accountName; "allRecordsAccounts"; "Pick an account")
End case 

$oldName:=$accountName
$newName:=Request:C163("Rename to:"; $accountName)

checkInit
checkIfAccountIDExists(->$oldName; "Old Account Name")
checkIfNullString(->$newName; "New account ID")
// check if the new name already exist
If (doesRecordExist(->[Accounts:9]; ->[Accounts:9]AccountID:1; ->$newName))
	checkAddError("Account <Y> already exist. Merge <X> into <y>?"; $oldName; $newName)
End if 

If ($oldName=$newName)
	checkAddError("<X> is the current Account ID"; $oldName)
End if 

checkIfUserIsAdmin


If (isValidationConfirmed)
	If (Records in selection:C76([Accounts:9])=1)
		CONFIRM:C162("Are you sure you want to replace "+$oldName+" to "+$newName+"?")
		
		If ((OK=1) & ($oldName#$newName))
			// Accounts
			READ WRITE:C146([Accounts:9])
			QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$oldName)
			APPLY TO SELECTION:C70([Accounts:9]; [Accounts:9]AccountID:1:=$newName)
			
			// Registers
			READ WRITE:C146([Registers:10])
			QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$oldName)
			APPLY TO SELECTION:C70([Registers:10]; [Registers:10]AccountID:6:=$newName)
			
			//Wire
			READ WRITE:C146([Wires:8])
			QUERY:C277([Wires:8]; [Wires:8]CXR_AccountID:11=$oldName)
			APPLY TO SELECTION:C70([Wires:8]; [Wires:8]CXR_AccountID:11:=$newName)
			
			//eWire
			READ WRITE:C146([Accounts:9])
			QUERY:C277([eWires:13]; [eWires:13]AccountID:30=$oldName)
			APPLY TO SELECTION:C70([eWires:13]; [eWires:13]AccountID:30:=$newName)
			
			//AccountInOuts
			READ WRITE:C146([AccountInOuts:37])
			QUERY:C277([AccountInOuts:37]; [AccountInOuts:37]AccountID:6=$oldName)
			APPLY TO SELECTION:C70([AccountInOuts:37]; [AccountInOuts:37]AccountID:6:=$newName)
			
			
			//Cheques
			READ WRITE:C146([Cheques:1])
			QUERY:C277([Cheques:1]; [Cheques:1]AccountID:7=$oldName)
			APPLY TO SELECTION:C70([Cheques:1]; [Cheques:1]AccountID:7:=$newName)
			
			//Items
			READ WRITE:C146([Items:39])
			QUERY:C277([Items:39]; [Items:39]AccountID:12=$oldName)
			APPLY TO SELECTION:C70([Items:39]; [Items:39]AccountID:12:=$newName)
			//QUERY([Items];[Items]_=$oldName)
			//APPLY TO SELECTION([Items];[Items]_:=$newName)
			
			//Items In Out
			READ WRITE:C146([ItemInOuts:40])
			QUERY:C277([ItemInOuts:40]; [ItemInOuts:40]accountID:13=$oldName)
			APPLY TO SELECTION:C70([ItemInOuts:40]; [ItemInOuts:40]accountID:13:=$newName)
			
			
			// Transfer Templates
			READ WRITE:C146([TransferTemplates:54])
			QUERY:C277([TransferTemplates:54]; [TransferTemplates:54]fromAccount:3=$oldName)
			APPLY TO SELECTION:C70([TransferTemplates:54]; [TransferTemplates:54]fromAccount:3:=$newName)
			QUERY:C277([TransferTemplates:54]; [TransferTemplates:54]toAccount:4=$oldName)
			APPLY TO SELECTION:C70([TransferTemplates:54]; [TransferTemplates:54]toAccount:4:=$newName)
			
			// Fee Rules
			QUERY:C277([FeeRules:59]; [FeeRules:59]Method:4=c_Account; *)
			QUERY:C277([FeeRules:59];  & ; [FeeRules:59]SubMethod:5=$oldName)
			APPLY TO SELECTION:C70([FeeRules:59]; [FeeRules:59]SubMethod:5:=$newName)
			
			// AML Rules
			QUERY:C277([AMLRules:74]; [AMLRules:74]ifMethod:4=c_Account; *)
			QUERY:C277([AMLRules:74];  & ; [AMLRules:74]ifSubMethod:5=$oldName)
			APPLY TO SELECTION:C70([AMLRules:74]; [AMLRules:74]ifSubMethod:5:=$newName)
			
		Else 
			myAlert("Nothing was affected")
		End if 
	End if 
End if 
