//%attributes = {}
// queryRegistersByAccountID (accountID;{branchID}) : longint
// select registers by accountID and returns the number of records in selection


C_TEXT:C284($accountID; $branchID; $1; $2)
C_LONGINT:C283($0)

$accountID:=$1
READ ONLY:C145([Registers:10])
SET QUERY DESTINATION:C396(Into current selection:K19:1)

Case of 
	: (Count parameters:C259=1)
		QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$accountID)  // load all the registers for this account
		
	: (Count parameters:C259=2)
		$branchID:=$2
		
		If ($branchID="")
			QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$accountID)
		Else 
			QUERY:C277([Registers:10]; [Registers:10]BranchID:39=$branchID; *)  // composite index on Branch+AccountID
			QUERY:C277([Registers:10];  & ; [Registers:10]AccountID:6=$accountID)  // composite index search
			
		End if 
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$0:=Records in selection:C76([Registers:10])