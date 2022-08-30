//%attributes = {}
// createSanctionCheckLogRecord ($fullName; $tableNum; $internalRecordID; $userUID; $sanctionList; $sanctionCheckTextResult;$checkResult;$isEntity;$currentDate;$currentTime)
// Creates a new entry in the Sanction List Check Log

C_TEXT:C284($1; $fullName)
C_LONGINT:C283($2; $tableNum)
C_TEXT:C284($3; $internalRecordID; $4; $userUID; $5; $sanctionList; $6; $sanctionCheckTextResult)
C_BOOLEAN:C305($7; $checkSuccessful; $isSuccessful)
C_LONGINT:C283($8; $checkResult)
C_BOOLEAN:C305($9; $isEntity)
C_DATE:C307($10; $currentDate)
C_TIME:C306($11; $currentTime)
C_OBJECT:C1216($12; $reportJSON)

Case of 
		
	: (Count parameters:C259=11)
		
		$fullName:=$1
		$tableNum:=$2
		$internalRecordID:=$3
		$userUID:=$4
		$sanctionList:=$5
		$sanctionCheckTextResult:=$6
		$isSuccessful:=$7
		$checkResult:=$8
		$isEntity:=$9
		$currentDate:=$10
		$currentTime:=$11
		$reportJSON:=Null:C1517
	: (Count parameters:C259=12)
		
		$fullName:=$1
		$tableNum:=$2
		$internalRecordID:=$3
		$userUID:=$4
		$sanctionList:=$5
		$sanctionCheckTextResult:=$6
		$isSuccessful:=$7
		$checkResult:=$8
		$isEntity:=$9
		$currentDate:=$10
		$currentTime:=$11
		$reportJSON:=$12
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


READ WRITE:C146([SanctionCheckLog:111])


//  // If the record was recently recorded do not save it again
//QUERY([SanctionCheckLog];[SanctionCheckLog]InternalRecordID=$id;*)
//QUERY([SanctionCheckLog]; & ;[SanctionCheckLog]CheckTime>=Current time(*)-(<>LimitToRecheckSanctionList*60))
//
//If (Records in selection([SanctionCheckLog])=0)
If ($tableNum#0)
	
	CREATE RECORD:C68([SanctionCheckLog:111])
	
	[SanctionCheckLog:111]CheckDate:3:=Current date:C33(*)
	[SanctionCheckLog:111]CheckTime:4:=Current time:C178(*)
	
	[SanctionCheckLog:111]UserID:8:=$userUID
	[SanctionCheckLog:111]InternalRecordID:2:=$internalRecordID
	[SanctionCheckLog:111]SanctionList:5:=$sanctionList
	[SanctionCheckLog:111]isSuccessful:7:=$isSuccessful
	If ($checkResult#0)
		[SanctionCheckLog:111]ResponseText:6:=$sanctionCheckTextResult
	End if 
	[SanctionCheckLog:111]CheckResult:10:=$checkResult
	[SanctionCheckLog:111]FullName:9:=$fullName
	[SanctionCheckLog:111]internalFieldID:13:=0
	[SanctionCheckLog:111]internalTableID:12:=$tableNum
	[SanctionCheckLog:111]isEntity:11:=$isEntity
	[SanctionCheckLog:111]ResponseJSON:17:=$reportJSON
	
	SAVE RECORD:C53([SanctionCheckLog:111])
	UNLOAD RECORD:C212([SanctionCheckLog:111])
	UNLOAD RECORD:C212([SanctionLists:113])
End if 


// End if 

READ ONLY:C145([SanctionCheckLog:111])

