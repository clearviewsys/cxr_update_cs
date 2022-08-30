//%attributes = {}
// duplicateRecordTable (->table;->fieldToDuplicate;Name of Field)
// e.g. duplicateRecordTable (->[Currencies];->[Currencies]CurrencyCode;"Currency Alias")

C_TEXT:C284($fieldName; $CURR; $accountID; $1)
C_TEXT:C284($oldAccountName; $newAccountName)
C_LONGINT:C283($i)

$fieldName:="Account Name"
Case of 
	: (Count parameters:C259=1)
		$accountID:=$1
		
	Else 
		$accountID:=Request:C163("Account Name:")
		
End case 


QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$accountID)
If (Records in selection:C76([Accounts:9])=0)
	myAlert("Account "+$accountID+" does not exist.")
Else 
	
	READ ONLY:C145([Currencies:6])
	ALL RECORDS:C47([Currencies:6])
	READ ONLY:C145([Accounts:9])
	
	FIRST RECORD:C50([Currencies:6])
	For ($i; 1; Records in selection:C76([Currencies:6]))
		$CURR:=[Currencies:6]ISO4217:31
		If ([Currencies:6]hasCashAccount:23)
			
			READ WRITE:C146([Accounts:9])
			QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$accountID)
			
			If (Records in selection:C76([Accounts:9])=1)  // if there is a record
				
				LOAD RECORD:C52([Accounts:9])
				$oldAccountName:=[Accounts:9]AccountID:1
				$newAccountName:=$oldAccountName+"-"+$CURR
				
				DUPLICATE RECORD:C225([Accounts:9])
				
				[Accounts:9]AccountID:1:=$newAccountName
				[Accounts:9]Currency:6:=$CURR
				
				[Accounts:9]_Sync_ID:27:=""  //2/21/16 IBB
				
				SAVE RECORD:C53([Accounts:9])
				
				//UNLOAD RECORD($tablePtr->)
			End if 
			READ ONLY:C145([Accounts:9])
			
		End if 
		// unload record([currencies])` this may be a good idea to add (the unload record), haven't tested yet
		NEXT RECORD:C51([Currencies:6])
	End for 
	
End if 
