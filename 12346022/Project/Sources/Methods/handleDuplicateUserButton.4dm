//%attributes = {}

// handleDuplicateUserButton (USERSET)

C_TEXT:C284($userSet; $1)
Case of 
	: (Count parameters:C259=1)
		$userSet:=$1
	Else 
		$userSet:="UserSet"
End case 

C_TEXT:C284($newUserId; $oldUserID; $userName)

If (Records in set:C195($userSet)=1)
	USE SET:C118($userSet)
	
	LOAD RECORD:C52([Users:25])
	C_LONGINT:C283($seq)
	
	//$seq:=Get database parameter([Users];Table sequence number)
	//SET DATABASE PARAMETER([Users];Table sequence number;$seq+1)
	
	$oldUserID:=[Users:25]UserID:1
	$userName:=[Users:25]UserName:3
	DUPLICATE RECORD:C225([Users:25])
	$newUserId:=makeUsersID
	[Users:25]UUID:32:=Generate UUID:C1066
	[Users:25]UserID:1:=$newUserId
	[Users:25]UserName:3:=$userName+" Copy"
	[Users:25]Password:4:=""
	[Users:25]Reminder:5:=""
	[Users:25]email:39:=""
	[Users:25]accountNumber:43:=""
	[Users:25]numAttempts:35:=0
	[Users:25]isHashed:36:=False:C215
	[Users:25]resetCode:37:=""
	[Users:25]resetCodeExpiryDate:40:=!00-00-00!
	
	[Users:25]_Sync_ID:23:=""  //2/21/16 IBB
	SET BLOB SIZE:C606([Users:25]_Sync_Data:24; 0)
	SAVE RECORD:C53([Users:25])
	UNLOAD RECORD:C212([Users:25])
	
	allRecordsUsers
	HIGHLIGHT RECORDS:C656([Users:25]; $userSet)
	
	
	// _____________________________duplicate the privileges
	
	READ WRITE:C146([Privileges:24])
	
	QUERY:C277([Privileges:24]; [Privileges:24]UserID:1=$oldUserID)  // find all privileges for the user
	CREATE SET:C116([Privileges:24]; "$PVL")
	
	C_LONGINT:C283($i; $n; $tableNo)
	C_BOOLEAN:C305($canCreate; $canModify; $canDelete; $canView; $canPrint; $canImport; $canExport)
	
	$n:=Records in set:C195("$PVL")
	FIRST RECORD:C50([Privileges:24])
	
	For ($i; 1; $n)
		GOTO SELECTED RECORD:C245([Privileges:24]; $i)
		LOAD RECORD:C52([Privileges:24])
		
		DUPLICATE RECORD:C225([Privileges:24])  // duplicate the record
		[Privileges:24]UserID:1:=$newUserID
		[Privileges:24]UUID:13:=Generate UUID:C1066
		[Privileges:24]_Sync_ID:10:=""  //2/21/16 IBB
		SET BLOB SIZE:C606([Privileges:24]_Sync_Data:11; 0)
		
		SAVE RECORD:C53([Privileges:24])
		USE SET:C118("$PVL")  // use the full set
	End for 
	
	CLEAR SET:C117("$PVL")
Else 
	myAlert("Please highlight a User for duplication.")
End if 