//%attributes = {}
// createRecordNotes( customerId; Note; isAML? ) 
// this method creates a note for a particular customer

C_TEXT:C284($customerID; $1)
C_TEXT:C284($notes; $2)
C_BOOLEAN:C305($isAML; $3)

Case of 
	: (Count parameters:C259=0)
		$customerID:="QSCUS1011661"
		$notes:="test notes"
		$isAML:=True:C214
		
	: (Count parameters:C259=2)
		$customerID:=$1
		$notes:=$2
		$isAML:=False:C215
		
	: (Count parameters:C259=3)
		$customerID:=$1
		$notes:=$2
		$isAML:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

CREATE RECORD:C68([CallLogs:51])
[CallLogs:51]UUID:12:=Generate UUID:C1066
[CallLogs:51]CallLogID:1:=makeCallLogID
[CallLogs:51]CallDate:3:=Current date:C33
[CallLogs:51]CallTime:4:=Current time:C178
[CallLogs:51]userID:5:=getApplicationUser
[CallLogs:51]BranchID:9:=getBranchID
[CallLogs:51]CustomerID:2:=$customerID
[CallLogs:51]Notes:6:=$notes
[CallLogs:51]isAML:13:=$isAML

SAVE RECORD:C53([CallLogs:51])
UNLOAD RECORD:C212([CallLogs:51])
READ ONLY:C145([CallLogs:51])
